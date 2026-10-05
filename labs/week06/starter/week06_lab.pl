% BS0030 Week 6 Lab — Logic Programming II
% Student starter: lists, safe search, negation, and CLP(FD).
% Copy to labs/week06/work/week06_lab.pl before editing.

:- use_module(library(clpfd)).

% Part 1 — recursive list relations
member_of(_X, _List) :-
    % TODO: replace with base and recursive clauses.
    fail.

append_to(_Xs, _Ys, _Zs) :-
    % TODO: replace with base and recursive clauses.
    fail.

% Reflection: why can append_to(A,B,[1,2,3]) generate several splits?
% TODO:

% Part 2 — cycle-safe route search
edge(riga, kaunas).
edge(kaunas, riga).
edge(kaunas, vilnius).
edge(vilnius, kaunas).
edge(riga, tallinn).
edge(tallinn, helsinki).
edge(helsinki, tallinn).
edge(vilnius, warsaw).

route(From, To, Path) :-
    % TODO: helper carries a visited list.
    route_(From, To, [From], ReversePath),
    reverse(ReversePath, Path).

route_(_From, _To, _Visited, _Path) :-
    % TODO: base and recursive cases.
    fail.

% Reflection: cycles, termination, and the Visited invariant.
% TODO:

% Part 3 — negation as failure and goal order
student(alice).
student(bob).
student(carla).

passed(alice).
passed(carla).

needs_retry(_Student) :-
    % TODO: generate a student, then apply negation as failure.
    fail.

bad_needs_retry(Student) :-
    \+ passed(Student),
    student(Student).

% Reflection: why does order matter, and why is \+ not classical negation?
% TODO:

% Part 4 — =, is, and #=
% Run the assignment queries and explain the distinction.
% TODO:

% Part 5 — propagation and labeling
pair_sum(_X, _Y) :-
    % TODO: domains 1..10, sum #= 10, X #< Y.
    fail.

% Reflection: compare before and after labeling.
% TODO:

% Part 6 — scheduling with CLP(FD)
schedule(_A, _B, _C) :-
    % TODO: domains 1..3, all different, A before C, B #\= 1.
    fail.

% Extension — N-Queens
n_queens(_N, _Queens) :-
    % Optional extension.
    fail.
