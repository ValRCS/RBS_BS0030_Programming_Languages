xtension · PL
% A3 extension — four-task scheduling with CLP(FD)
% Load from labs/week06 with:  ?- [work/a3_extension].
 
:- use_module(library(clpfd)).
 
% Variables: A, B, C, D are the slots of tasks a, b, c, d.
% Domains:   each slot is in 1..4.
% Constraints:
%   - all four tasks occupy distinct slots
%   - a is before c
%   - b is not in slot 1
%   - d is after b
% This predicate only posts constraints. It does not enumerate; labeling is
% done by the caller so propagation and enumeration stay separate.
schedule4(A, B, C, D) :-
    [A, B, C, D] ins 1..4,
    all_different([A, B, C, D]),
    A #< C,
    B #\= 1,
    D #> B.
 
% Enumerate every solution as a list of [A,B,C,D].
all_schedules(Solutions) :-
    findall([A, B, C, D],
            ( schedule4(A, B, C, D),
              labeling([], [A, B, C, D]) ),
            Solutions).
 
% ---------------------------------------------------------------------------
% Test queries (run at the swipl prompt; not part of the model)
% ---------------------------------------------------------------------------
% 1. Propagation only (no labeling):
%      ?- schedule4(A, B, C, D).
%
% 2. All solutions, one at a time with ;:
%      ?- schedule4(A, B, C, D), labeling([], [A, B, C, D]).
%
% 3. All solutions as a list, and how many:
%      ?- all_schedules(S), length(S, N).
%
% 4. Impossible cases (should print false, not hang):
%      ?- schedule4(A, B, C, D), D #= 1.     % d after b, but b >= 2
%      ?- schedule4(A, B, C, D), C #= 1.     % a before c, but a >= 1
%
% 5. Checking a given schedule (a=1, b=2, c=4, d=3):
%      ?- schedule4(1, 2, 4, 3).             % true
%      ?- schedule4(2, 1, 3, 4).             % false (b in slot 1)