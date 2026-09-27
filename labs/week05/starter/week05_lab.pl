% BS0030 Week 5 Lab — Logic Programming I
% Student starter for SWI-Prolog.
%
% Copy to labs/week05/work/week05_lab.pl before editing.
% Load from labs/week05 with:
%   ?- [work/week05_lab].
% Reload after edits:
%   ?- make.

% ---------------------------------------------------------------------------
% Part 0 — facts
% ---------------------------------------------------------------------------

parent(alice, bob).
parent(alice, david).
parent(bob, clara).
parent(clara, daniel).
parent(david, eva).

student(anna).
student(ben).
student(cara).
student(dan).

enrolled(anna, bs0030).
enrolled(ben, bs0030).
enrolled(cara, bs0013).
enrolled(dan, bs0030).
enrolled(anna, bs0013).

passed(ben, bs0030).
passed(cara, bs0030).
passed(dan, algorithms).

% A small acyclic route graph for Part 8.
edge(riga, jelgava).
edge(jelgava, siauliai).
edge(siauliai, kaunas).
edge(riga, sigulda).

% ---------------------------------------------------------------------------
% Part 1 — inverse relation
% ---------------------------------------------------------------------------

child(Child, Parent) :-
    % TODO: derive this from parent/2.
    fail.

% ---------------------------------------------------------------------------
% Part 2 — conjunction / resolution
% ---------------------------------------------------------------------------

grandparent(Grandparent, Grandchild) :-
    % TODO: connect two parent/2 goals through an intermediate person.
    fail.

% Add your manual grandparent(alice, clara) trace here:
%
% TRACE:
% ...

% ---------------------------------------------------------------------------
% Part 4 — relations in several modes
% ---------------------------------------------------------------------------

takes_programming_languages(Student) :-
    % TODO: derive from enrolled/2.
    fail.

classmate(A, B) :-
    % TODO: same course, but A and B must be different. Use dif/2.
    fail.

% ---------------------------------------------------------------------------
% Part 5 — recursion
% ---------------------------------------------------------------------------

ancestor(X, Y) :-
    % TODO: base case — one parent edge.
    fail.

ancestor(X, Y) :-
    % TODO: recursive case — make progress through an intermediate Z.
    fail.

% ---------------------------------------------------------------------------
% Part 6 — backtracking through conjunction
% ---------------------------------------------------------------------------

successful_bs0030_student(Student) :-
    % TODO: Student must satisfy two goals.
    fail.

% Add a short backtracking trace here.
%
% TRACE:
% ...

% ---------------------------------------------------------------------------
% Part 7 — goal/clause ordering experiment
% ---------------------------------------------------------------------------

passed_bs0030_a(Student) :-
    student(Student),
    passed(Student, bs0030).

passed_bs0030_b(Student) :-
    passed(Student, bs0030),
    student(Student).

% Deliberately poor recursion. Read and explain; do not wait on a hanging query.
bad_ancestor(X, Y) :-
    bad_ancestor(X, Z),
    parent(Z, Y).
bad_ancestor(X, Y) :-
    parent(X, Y).

% ORDERING NOTES:
% ...

% ---------------------------------------------------------------------------
% Part 8 — route reachability
% ---------------------------------------------------------------------------

reachable(X, Y) :-
    % TODO: direct edge.
    fail.

reachable(X, Y) :-
    % TODO: edge to an intermediate Z, then continue recursively.
    fail.

% CYCLE NOTE:
% ...

% ---------------------------------------------------------------------------
% Part 3 — unification notes
% (Placed here so all written answers can remain in the source file.)
% ---------------------------------------------------------------------------

% 1. Why pair(X,X) = pair(alice,bob) fails:
% ...
%
% 2. Why = is unification rather than assignment:
% ...
%
% 3. Structural requirement for compound-term unification:
% ...

% ---------------------------------------------------------------------------
% Part 9 — final explanation
% ---------------------------------------------------------------------------

% 1. Fact vs rule vs query:
% ...
%
% 2. What unification does:
% ...
%
% 3. Choice point:
% ...
%
% 4. What backtracking restores:
% ...
%
% 5. ancestor/2 versus a one-directional Python function:
% ...
%
% 6. Declarative meaning versus operational behavior:
% ...
