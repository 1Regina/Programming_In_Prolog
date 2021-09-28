p([1, 2, 3]).
p([the, cat, sat, [on, the, mat]]).

/* Fact: X as a member of the list that has X as its head */
member(X, [X|_]).
/* As a rule alternatively*/
member(X, [Y|_]) :- X = Y.
/* recursion : X is a member of the list if X is a member of the tail of the list*/
member(X, [_|Y]) :- member(X,Y).

/* try to put rules before fact except for special case like below */
islist([A|B]) :- islist(B).
islist([]).