'use strict';
// Pure domain decision: no I/O, event bus, or mutable global state.
function allowed(active, limit) {
  if (!Number.isInteger(active) || !Number.isInteger(limit) || active < 0 || limit < 1) return false;
  return active < limit;
}
module.exports = { allowed };
