'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const { allowed } = require('../starter/lending.cjs');
const { createLendingBus } = require('../starter/events.cjs');
test('pure lending decision handles boundary and invalid inputs', () => {
  assert.equal(allowed(2, 3), true);
  assert.equal(allowed(3, 3), false);
  assert.equal(allowed(-1, 3), false);
});
test('event handlers execute synchronously in registration order', () => {
  const app = createLendingBus();
  app.bus.emit('borrow-request', { memberId: 7, bookId: 12, active: 2, limit: 3 });
  assert.deepEqual(app.history, [
    { kind: 'decision', permitted: true },
    { kind: 'audit', memberId: 7 }
  ]);
  app.dispose();
  assert.equal(app.bus.listenerCount('borrow-request'), 0);
  app.bus.emit('borrow-request', { memberId: 8, active: 0, limit: 2 });
  assert.equal(app.history.length, 2);
});
test('microtask precedes timer after synchronous execution', async () => {
  const seen = ['sync'];
  await new Promise(resolve => {
    setTimeout(() => { seen.push('timer'); resolve(); }, 0);
    queueMicrotask(() => seen.push('microtask'));
  });
  assert.deepEqual(seen, ['sync', 'microtask', 'timer']);
});
