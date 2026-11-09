'use strict';
const { createLendingBus } = require('./events.cjs');
const request = require('./fixture.json');
const app = createLendingBus();
app.bus.emit('borrow-request', request);
console.log(app.history);
app.dispose();
console.log('listeners after cleanup:', app.bus.listenerCount('borrow-request'));
