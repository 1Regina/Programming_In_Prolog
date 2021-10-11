
father(mary, george).
father(john, george).
father(sue, harry).
father(george, edward).

/* reversal of father relationship to child */
child(X, Y) :- father(Y, X).
father(X) :- father(_,X).

person(adam).
person(X) :- mother(X, Y).
person(eve).

mother(cain, eve).
mother(abel, eve).
mother(jabal, adah).
mother(tubalcain, zillah).

/* Dance Party */
possible_pair(X, Y) :- boy(X), girl(Y).

boy(john).
boy(marmaduke).
boy(bertram).
boy(charles).

girl(griselda).
girl(ermintrude).
girl(brunhilde).
