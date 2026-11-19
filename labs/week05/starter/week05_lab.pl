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
    parent(Parent, Child).

% ?- child(bob, alice).   true.
% ?- child(X, alice).     X = bob ; X = david.
% ?- child(clara, X).     X = bob.

% ---------------------------------------------------------------------------
% Part 2 — conjunction / resolution
% ---------------------------------------------------------------------------

grandparent(Grandparent, Grandchild) :-
    parent(Grandparent, Intermediate),
    parent(Intermediate, Grandchild).

% ?- grandparent(alice, clara).  true.
% ?- grandparent(alice, X).      X = clara ; X = eva.
% ?- grandparent(X, daniel).     X = bob.

% Add your manual grandparent(alice, clara) trace here:
%
% TRACE:
% grandparent(alice, clara)
% match head grandparent(G, C) with G = alice, C = clara
% new goals: parent(alice, Intermediate), parent(Intermediate, clara)
% goal 1: parent(alice, Intermediate); first matching fact parent(alice, bob)
% binds Intermediate = bob  (choice point left: parent(alice, david))
% goal 2 becomes parent(bob, clara); fact parent(bob, clara) matches
% success
% (Had goal 2 failed, Prolog would backtrack, undo Intermediate = bob and
% try Intermediate = david, which gives parent(david, clara) - no fact.)

% ---------------------------------------------------------------------------
% Part 4 — relations in several modes
% ---------------------------------------------------------------------------

takes_programming_languages(Student) :-
    % TODO: derive from enrolled/2.
    enrolled(Student, bs0030).

% ?- takes_programming_languages(anna).  true.
% ?- takes_programming_languages(X).     X = anna ; X = ben ; X = dan.
%
% (The starter used  Course =:= bs0030 .  =:= is arithmetic comparison and
%  raises a type error on atoms; the course is simply written in the
%  enrolled/2 goal and unification does the matching.)

classmate(A, B) :-
    % TODO: same course, but A and B must be different. Use dif/2.
    enrolled(A, Course),
    enrolled(B, Course),
    dif(A, B).

% ?- classmate(anna, ben).   true.
% ?- classmate(anna, anna).  false.   (dif fails)
% ?- classmate(anna, X).     X = ben ; X = dan ; X = cara.
% ?- classmate(A, B).        all ordered pairs sharing a course.
%
% Symmetry: the rule says nothing about which of A and B comes first. It only
% needs a shared Course and A \= B. If classmate(anna, ben) holds via bs0030,
% the same enrolled facts satisfy classmate(ben, anna), so both answers appear.

% ---------------------------------------------------------------------------
% Part 5 — recursion
% ---------------------------------------------------------------------------

ancestor(X, Y) :-
    % TODO: base case — one parent edge.
    parent(X, Y).

ancestor(X, Y) :-
    % TODO: recursive case — make progress through an intermediate Z.
    parent(X, Z),
    ancestor(Z, Y).

% ?- ancestor(alice, bob).     true.
% ?- ancestor(alice, daniel).  true.
% ?- ancestor(alice, X).       X = bob ; david ; clara ; daniel ; eva.
% ?- ancestor(X, daniel).      X = clara ; alice ; bob.
% ?- ancestor(daniel, alice).  false.   (daniel has no children)
%
% ancestor(alice, daniel):
%   base clause: parent(alice, daniel)? no fact -> fails.
%   recursive clause: parent(alice, Z) -> Z = bob
%       ancestor(bob, daniel): base parent(bob, daniel)? no.
%         recursive: parent(bob, Z') -> Z' = clara
%           ancestor(clara, daniel): base parent(clara, daniel) -> yes.
%   So the chain is alice -> bob -> clara -> daniel: the recursive variable
%   took the values bob, then clara; the base case finally succeeded at clara.
%   Each recursive call moves one parent edge down the tree, so it terminates.

% ---------------------------------------------------------------------------
% Part 6 — backtracking through conjunction
% ---------------------------------------------------------------------------

successful_bs0030_student(Student) :-
    % TODO: Student must satisfy two goals.
    student(Student),
    passed(Student, bs0030).

% Predictions for ?- successful_bs0030_student(X).
%  1. First candidate from student/1: X = anna.
%  2. passed(anna, bs0030)? No such fact -> fails.
%  3. Prolog backtracks to the most recent choice point, student/1.
%  4. First reported solution: X = ben.
%  5. Typing ; gives X = cara. Then dan fails, and the query ends with false.

% Add a short backtracking trace here.
%
% TRACE:
% student(X)               X = anna
%   passed(anna, bs0030)   fails
% backtrack: undo X = anna
% student(X)               X = ben      (new binding)
%   passed(ben, bs0030)    succeeds  -> report X = ben
% on ';': backtrack, undo X = ben
% student(X)               X = cara
%   passed(cara, bs0030)   succeeds  -> report X = cara
% on ';': undo X = cara, X = dan
%   passed(dan, bs0030)    fails (dan only passed algorithms)
% no student/1 clauses left -> false.

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
% a vs b: both give X = ben ; X = cara on this finite knowledge base, so they
% describe the same conjunction (conjunction is logically commutative).
% Operationally they differ in what is generated and what is filtered:
%  _a generates every student (anna, ben, cara, dan) from student/1 and filters
%     each with passed/2: 4 candidates, anna and dan are rejected.
%  _b generates from passed(Student, bs0030), which only matches ben and cara,
%     and student/1 is just a check: 2 candidates, both accepted.
% Here _b does less work because passed/2 is the more selective goal. With
% other data the better order could be the other way round.
%
% bad_ancestor/2: Prolog tries clauses top to bottom and goals left to right,
% depth first. For bad_ancestor(alice, Y) the first clause's first goal is
% bad_ancestor(alice, Z): the same call with the same first argument, so it
% matches clause 1 again, and again, ... without ever consuming a parent edge
% and never reaching clause 2 (the base case). The stack grows until Prolog
% reports a resource error. Declaratively the program is a correct definition
% of ancestry; the problem is purely the search order (left recursion).

% ---------------------------------------------------------------------------
% Part 8 — route reachability
% ---------------------------------------------------------------------------

reachable(X, Y) :-
    % TODO: direct edge.
    edge(X, Y).

reachable(X, Y) :-
    % TODO: edge to an intermediate Z, then continue recursively.
    edge(X, Z),
    reachable(Z, Y).

% ?- reachable(riga, kaunas).      true.
% ?- reachable(riga, D).           D = jelgava ; sigulda ; siauliai ; kaunas.
% ?- reachable(jelgava, D).        D = siauliai ; kaunas.
% ?- reachable(S, kaunas).         S = siauliai ; riga ; jelgava.

% CYCLE NOTE:
% 1. On the acyclic graph every recursive step follows one edge forward, and
%    the edges eventually run out (kaunas and sigulda have no outgoing edges),
%    so each search path is finite and the search terminates.
% 2. After adding edge(kaunas, riga) a path can go
%    riga -> jelgava -> siauliai -> kaunas -> riga -> jelgava -> ... and
%    revisit riga forever. Queries with no answer (e.g. reachable(riga, paris))
%    would never finish, and even successful ones can loop after reporting
%    all answers when asked for more with ;.
% 3. Unification only binds variables inside one proof attempt, and
%    backtracking restores earlier state. Neither keeps a record of nodes
%    already visited on the current path, so the program has no way to notice
%    a repeat.
% 4. A safer predicate would carry extra state, e.g. a list of visited nodes
%    passed along as an extra argument (to be built in Week 6).
% 5. Declarative: "Y is reachable from X if there is an edge, or an edge to
%    some Z from which Y is reachable" - this is correct even with cycles.
%    Operational: how Prolog explores proofs (clause order, depth first, no
%    memory of visited nodes) is what makes it loop.

% ---------------------------------------------------------------------------
% Part 3 — unification notes
% (Placed here so all written answers can remain in the source file.)
% ---------------------------------------------------------------------------

% 1. Why pair(X,X) = pair(alice,bob) fails:
%   The same variable X appears twice, so both positions must receive the
%   same value. Unifying the first argument binds X = alice; the second
%   argument then requires alice = bob, and two different atoms never unify.
%
%
% 2. Why = is unification rather than assignment:
%    = does not copy a value into a variable; it asks whether two terms can be
%    made identical by choosing bindings for variables on either side, and
%    succeeds or fails. It works in both directions (parent(X,bob) =
%    parent(alice,Y) binds variables on both sides), and a variable that is
%    already bound is simply compared, not overwritten.
%
% 3. Structural requirement for compound-term unification:
%    The two terms must have the same functor (name) and the same arity.
%    Only then are the arguments unified pairwise, left to right, with
%    bindings carried forward.

% ---------------------------------------------------------------------------
% Part 9 — final explanation
% ---------------------------------------------------------------------------

% 1. Fact vs rule vs query:
%    A fact is an unconditional statement (parent(alice, bob).). A rule has a
%    head and a body (Head :- Body.) and says the head holds if the body goals
%    hold. A query is a goal we ask Prolog to prove, usually at ?-.
%
% 2. What unification does:
%    It matches two terms by finding variable bindings that make them
%    identical, or fails if none exist. It is how queries select facts, how
%    arguments are passed into rule bodies and how results come back.
%
% 3. Choice point:
%    A place in the search where more than one clause (or fact) could match,
%    so Prolog remembers the untried alternatives to come back to later.
%
% 4. What backtracking restores:
%    The state at the most recent choice point: variable bindings made since
%    then are undone, and the next untried alternative is attempted.
%
% 5. ancestor/2 versus a one-directional Python function:
%    A Python function maps given inputs to one output. ancestor/2 is a
%    relation: the same definition checks a pair, finds descendants
%    (ancestor(alice, X)) or finds ancestors (ancestor(X, daniel)), and can
%    return many answers on backtracking.
%
% 6. Declarative meaning versus operational behavior:
%    The logical reading says what is true, but Prolog answers by searching
%    clauses top to bottom and goals left to right, depth first. A logically
%    correct definition (bad_ancestor, or reachable on a cyclic graph) can
%    therefore loop or do needless work.