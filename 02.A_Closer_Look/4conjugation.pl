female(mary).

parent(C, M, F) :- mother(C, M), father(C, F).

mother(john, ann).
mother(mary, ann).

father(mary, fred).
father(john, fred).
