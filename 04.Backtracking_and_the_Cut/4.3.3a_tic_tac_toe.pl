line(b(X,Y,Z,_,_,_,_,_,_),X,Y,Z). /* top row */
line(b(_,_,_,X,Y,Z,_,_,_),X,Y,Z). /* second row */
line(b(_,_,_,_,_,_,X,Y,Z), X,Y,Z).
line(b(X,_,_,Y,_,_,Z,_,_),X,Y,Z).
line(b(_,X,_,_,Y,_,_,Z,_),X,Y,Z).
line(b(_,_,X,_,_,Y,_,_,Z),X,Y,Z).
line(b(X,_,_,_,Y,_,_,_,Z),X,Y,Z).
line(b(_,_,X,_,Y,_,Z,_,_),X,Y,Z).

/* Case where x-player is threatening to win on next move */
/* cut means 1 threat is enough to force a move */
forced_move(Board) :-
    line(Board,X,Y,Z),
    threatening(X,Y,Z),
    !.

threatening(e,x,x).
threatening(x,e,x).
threatening(x,x,e).