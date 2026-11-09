'use strict';
const { EventEmitter } = require('node:events');
const { allowed } = require('./lending.cjs');
function createLendingBus() {
  const bus = new EventEmitter();
  const history = [];
  function decide(request) {
    history.push({ kind: 'decision', permitted: allowed(request.active, request.limit) });
  }
  function audit(request) {
    history.push({ kind: 'audit', memberId: request.memberId });
  }
  // TODO: register both named handlers for 'borrow-request'.
  // TODO: return a dispose() method that removes these exact references.
  return { bus, history, decide, audit, dispose() { /* TODO */ } };
}
module.exports = { createLendingBus };
