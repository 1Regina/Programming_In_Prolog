/*1*/ is_integer(0).
/*2*/ is_integer(X) :-
            is_integer(Y),
            X is Y +1.


member(X, [X|_]).
member(X, [_|Y]) :- member(X,Y).