const { EventEmitter } = require('node:events');
const assert = require('node:assert/strict');
const bus = new EventEmitter();
let generation = 0;
const displayed = [];
const lookup = (query, delayMs) => new Promise(resolve =>
  setTimeout(() => resolve({ query, matches: [query.toUpperCase()] }), delayMs));
async function onSearch({query, delayMs}) {
  const mine = ++generation;
  try {
    const result = await lookup(query, delayMs);
    if (mine !== generation) return;
    displayed.push(result.query);
    console.log('display:', result.matches.join(', '));
  } catch (error) {
    if (mine === generation) console.error(error);
  }
}
function listener(payload) {
  void onSearch(payload).catch(console.error);
}
async function main() {
  bus.on('search', listener);
  try {
    bus.emit('search', {query: 'older', delayMs: 35});
    bus.emit('search', {query: 'newer', delayMs: 5});
    await new Promise(resolve => setTimeout(resolve, 50));
    assert.deepEqual(displayed, ['newer']);
    console.log('stale-result check passed');
  } finally {
    bus.off('search', listener);
    assert.equal(bus.listenerCount('search'), 0);
  }
}
main().catch(error => {console.error(error); process.exitCode = 1;});
