/*1*/ thief(john).

/*2*/ likes(mary, chocolate).  /* FACT */
/*3*/ likes(mary, wine).       /* FACT */
/*4*/ likes(john,X) :- likes(X, wine).  /* Rule */

/*5*/ may_steal(X,Y) :- thief(X), likes(X,Y). /* thief and likes are goals and may_steal is thhe rule */


