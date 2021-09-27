/* FACT */
father(X,Y).        /* X is the father of Y */
mother(X,Y).        /* X is the mother of Y */
male(X).            /* X is male */
female(X).          /* X is female */
parent(X,Y).        /* X is a parent of Y */
diff(X,Y).          /* X and Y are different */


/* RULE */
aunt(X,Y) :-
    female(X),
    sibling(X,Z),
    parent(Z,Y).

/* Q1.3 relationship question to solve */
is_mother(Mum)          :-           /* X is a mother */
    mother(Mum, Child).
is_father(Dad)          :-           /* X is a father */
    father(Dad, Child).
is_son(Son)             :-           /* X is a son */
    parent(Parent,Son),
    male(Son).
sister_of(Sis,Person)   :-           /* X is a sister of Y */
    female(Sis),
    parent(Parent,Sis),
    parent(Parent, Person),
    diff(Sis,Person).
grandpa_of(GDad,Y)      :-          /* X is a grandfather of Y */
    father(GDad, Parent),
    parent(Parent, Y).
sibling(Sib1,Sib2)      :-      /* X is a sibling of Y */
    diff(Sib1, Sib2),
    parent(Parent, Sib1),
    parent(Parent,Sib2).