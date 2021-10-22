/* error with cut before amendment*/
% number_of_parents(adam, 0) :- !.
% number_of_parents(eve, 0) :- !.
% number_of_parents(X,2).


/* corrective option 1 with cut */
% number_of_parents(adam, 0) :- !, N = 0.
% number_of_parents(eve, 0) :- !, N = 0.
% number_of_parents(X,2).

/* corrective option 2 with cut-fail \+ */
number_of_parents(adam, 0).
number_of_parents(eve, 0).
number_of_parents(X, 2) :- \+(X = adam), \+ (X = eve).
