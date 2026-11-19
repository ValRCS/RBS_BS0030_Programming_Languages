A3 Explanation

Files: week06_lab.pl (lists, routes, negation) and a3_extension.pl (four-task schedule).

1. Lists

member_of/2 and append_to/3 each have a base case and a recursive case on the tail.

prolog
?- member_of(X, [10,20,30]).
X = 10 ; X = 20 ; X = 30.

?- append_to(A, B, [1,2,3]).
A = [], B = [1,2,3] ;
A = [1], B = [2,3] ;
A = [1,2], B = [3] ;
A = [1,2,3], B = [].

The second query goes "backwards" and returns every split. So append_to is a relation between three lists, not a function with fixed inputs.

2. Routes with a cycle

route_/4 keeps a list of visited nodes and only goes to a node that is not in it.

prolog
?- route(riga, vilnius, P).
P = [riga, kaunas, vilnius].

?- route(riga, berlin, _).
false.

Without the visited list, the search could go riga, kaunas, riga, kaunas, ... forever, because the graph has a cycle. The list makes sure no node appears twice on the current path, so every path is finite and the search stops. berlin is unreachable and still ends with false.

3. Negation as failure
prolog
?- needs_retry(X).
X = bob.

?- bad_needs_retry(X).
false.

In needs_retry, student(Student) runs first, so Student is already one person when \+ passed(Student) runs. For bob, passed(bob) can't be proved, so \+ succeeds.

In bad_needs_retry, \+ passed(Student) runs while Student is still free. Prolog can prove passed(alice), so \+ fails straight away and bob is never tried.

\+ means "Prolog can't prove this". It is not the same as logical "not". It also doesn't bind variables, so the variable must be known first.

4. Four-task schedule
prolog
schedule4(A, B, C, D) :-
    [A, B, C, D] ins 1..4,
    all_different([A, B, C, D]),
    A #< C,
    B #\= 1,
    D #> B.

A, B, C, D are the slots of tasks a, b, c, d. The predicate only sets up the constraints. Labeling is done in the query.

Before labeling:

prolog
?- schedule4(A, B, C, D).
A in 1..3, ..., B in 2..3, C in 2..4, D in 3..4.

Nothing is chosen yet, but the domains are smaller. B can't be 1, and it can't be 4 because D must be after it. D must be after B, so D is 3 or 4.

After labeling:

prolog
?- schedule4(A,B,C,D), labeling([], [A,B,C,D]).
A=1,B=2,C=3,D=4 ; A=1,B=2,C=4,D=3 ; A=1,B=3,C=2,D=4.

There are 3 solutions, which I also checked by hand (B is 2 or 3, then a, c and d fill the rest). Propagation removes bad values first, so labeling tries much less than all 24 orderings.

Impossible tests:

prolog
?- schedule4(A, B, C, D), D #= 1.
false.
?- schedule4(A, B, C, D), C #= 1.
false.

D can't be in slot 1 because it is after b. C can't be in slot 1 because it is after a.

5. =, is, #=
X = 2+3 gives X = 2+3 (unification only, nothing is calculated).
X is 2+3 gives X = 5 (evaluates the right side).
X in 1..10, X+3 #= 8 gives X = 5 (a constraint that works with unknown variables).
6. Trade-off

I used one variable per task holding its slot, so "a before c" is just A #< C. If I used one variable per slot holding the task, ordering would be harder to write. Using constraints is also better than generating all permutations and testing them, because propagation cuts the search down first.