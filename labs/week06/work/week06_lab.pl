% BS0030 Week 6 Lab — Logic Programming II
% Student starter: lists, safe search, negation, and CLP(FD).
% Copy to labs/week06/work/week06_lab.pl before editing.
 
:- use_module(library(clpfd)).
 
% Part 1 — recursive list relations
% Base case: X is the head. Recursive case: X is somewhere in the tail.
member_of(X, [X|_Tail]).
member_of(X, [_Head|Tail]) :-
    member_of(X, Tail).
 
% Base case: appending to the empty list gives the second list.
% Recursive case: keep the head, append the tails.
append_to([], Ys, Ys).
append_to([X|Xs], Ys, [X|Zs]) :-
    append_to(Xs, Ys, Zs).
 
% ?- member_of(20, [10,20,30]).    true.
% ?- member_of(X, [10,20,30]).     X = 10 ; X = 20 ; X = 30.
% ?- append_to([1,2], [3,4], Z).   Z = [1,2,3,4].
% ?- append_to(A, B, [1,2,3]).     A = [], B = [1,2,3] ;
%                                  A = [1], B = [2,3] ;
%                                  A = [1,2], B = [3] ;
%                                  A = [1,2,3], B = [].
 
% Reflection: why can append_to(A,B,[1,2,3]) generate several splits?
% The definition states a relation between three lists: Zs is Xs followed by
% Ys. It does not say which argument is the input. With Zs known and Xs, Ys
% unknown, Prolog tries each clause in turn: the first clause gives the split
% [] + [1,2,3]; the recursive clause peels off one head element and tries
% again, giving [1] + [2,3], and so on. Each split is a different way to
% satisfy the same relation, found by backtracking. A one-direction function
% could only compute Zs from Xs and Ys.
 
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
    route_(From, To, [From], ReversePath),
    reverse(ReversePath, Path).
 
% Visited holds the current path, newest node first.
% Base case: we are at the destination, so the visited list is the path.
route_(To, To, Visited, Visited).
% Recursive case: follow an edge to a node not already on the path.
route_(From, To, Visited, Path) :-
    edge(From, Next),
    \+ member_of(Next, Visited),
    route_(Next, To, [Next|Visited], Path).
 
% ?- route(riga, vilnius, Path).   Path = [riga,kaunas,vilnius] ;  (and no
%      other path: every other route would revisit a node)
% ?- route(riga, warsaw, Path).    Path = [riga,kaunas,vilnius,warsaw].
% ?- route(riga, berlin, _).       false.  (terminates despite the cycles)
 
% Reflection: cycles, termination, and the Visited invariant.
% Naive depth-first reachability on a cyclic graph can follow
% riga -> kaunas -> riga -> kaunas -> ... forever, because nothing stops it
% from re-entering a node it has already left; unreachable destinations
% (like berlin) would never be reported as false. The Visited list gives the
% invariant "no node appears twice on the current path". The \+ check keeps
% it true at every step, so every path is finite and bounded by the number of
% nodes, and the search always terminates on this finite graph.
 
% Part 3 — negation as failure and goal order
student(alice).
student(bob).
student(carla).
 
passed(alice).
passed(carla).
 
% Generate a student first, then test it with negation as failure.
needs_retry(Student) :-
    student(Student),
    \+ passed(Student).
 
bad_needs_retry(Student) :-
    \+ passed(Student),
    student(Student).
 
% ?- needs_retry(X).        X = bob.
% ?- bad_needs_retry(X).    false.   (bob is a student who has not passed,
%                                     yet this fails)
 
% Reflection: why does order matter, and why is \+ not classical negation?
% In bad_needs_retry, \+ passed(Student) runs while Student is still unbound.
% It asks "can passed(_) be proved for some student?" The answer is yes
% (alice), so \+ fails and the whole goal fails before student/1 ever
% generates bob. In needs_retry, Student is already bound to one candidate
% when \+ runs, so it tests that one student. \+ is negation as failure: it
% succeeds when Prolog cannot prove the goal, which means "not provable from
% the knowledge base", not "false in logic". It also never binds variables,
% so it is only reliable on sufficiently instantiated goals.
 
% Part 4 — =, is, and #=
% ?- X = 2 + 3.                 X = 2+3.   (unification: X is bound to the
%                                           term 2+3, nothing is calculated)
% ?- X is 2 + 3.               X = 5.     (arithmetic evaluation of the
%                                           right side, one direction only)
% ?- X in 1..10, X + 3 #= 8.   X = 5.     (constraint: relates X and numbers
%                                           in both directions, over a domain)
%
% = unifies two terms structurally. is evaluates the right-hand expression
% (which must be fully known) and unifies the result with the left side.
% #= states an arithmetic equality as a constraint over finite domains, so it
% can be used with unknown variables, propagates information, and is solved
% in any direction.
 
% Part 5 — propagation and labeling
pair_sum(X, Y) :-
    X in 1..10,
    Y in 1..10,
    X + Y #= 10,
    X #< Y.
 
% ?- pair_sum(X, Y).
%    X in 1..8, X+Y#=10, Y in 2..9.     (domains narrowed, nothing chosen)
% ?- pair_sum(X, Y), labeling([], [X,Y]).
%    X = 1, Y = 9 ; X = 2, Y = 8 ; X = 3, Y = 7 ; X = 4, Y = 6.
 
% Reflection: compare before and after labeling.
% Before labeling, propagation has only reduced the domains: X #< Y with
% X + Y #= 10 rules out X = 9, 10 and Y = 1, 10, so X is in 1..8 and Y in
% 2..9. No values are chosen yet and the answer is a set of remaining
% possibilities, not a solution. After labeling, Prolog enumerates concrete
% values from those reduced domains and the constraints discard the rest,
% leaving the four real solutions. Propagation shrank the search space
% first, so labeling tries far fewer candidates than generate-and-test over
% all 100 pairs from 1..10.
 
% Part 6 — scheduling with CLP(FD)
schedule(A, B, C) :-
    [A, B, C] ins 1..3,
    all_different([A, B, C]),
    A #< C,
    B #\= 1.
 
% ?- schedule(A, B, C), labeling([], [A,B,C]).
%    A = 1, B = 2, C = 3 ;
%    A = 1, B = 3, C = 2.
% Check by hand: slots are distinct; a is before c (1<3, 1<2); b is not in
% slot 1. No other assignment of 1..3 satisfies all three constraints.
 
% Extension — N-Queens
% Qs is a list where position is the column and the value is the row.
n_queens(N, Queens) :-
    length(Queens, N),
    Queens ins 1..N,
    all_different(Queens),
    no_diagonal_attacks(Queens),
    labeling([ff], Queens).   % enumeration starts here
 
no_diagonal_attacks([]).
no_diagonal_attacks([Q|Qs]) :-
    no_attack(Q, Qs, 1),
    no_diagonal_attacks(Qs).
 
no_attack(_, [], _).
no_attack(Q, [Q1|Qs], Distance) :-
    Q #\= Q1 + Distance,
    Q #\= Q1 - Distance,
    NextDistance is Distance + 1,
    no_attack(Q, Qs, NextDistance).
 
% ?- n_queens(4, Qs).   Qs = [2,4,1,3] ; Qs = [3,1,4,2].
% Variables: one per column (the row of its queen). Domains: 1..N.
% Constraints: all rows different, no two queens on a diagonal.
% Enumeration begins at labeling/2 in n_queens/2.