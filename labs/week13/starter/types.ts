type BorrowRequest = { memberId: number; bookId: number; active: number; limit: number };
type DomainEvent = { kind: 'borrow'; request: BorrowRequest } | { kind: 'return'; loanId: number };
function isBorrowRequest(value: unknown): value is BorrowRequest {
  // TODO: check non-null object, required fields, and finite integer values.
  return false;
}
const raw: unknown = JSON.parse('{"memberId":7,"bookId":12,"active":2,"limit":3}');
if (!isBorrowRequest(raw)) throw new Error('Invalid borrow request');
const event: DomainEvent = { kind: 'borrow', request: raw };
console.log(event.kind === 'borrow' ? event.request.bookId : event.loanId);
