spaces(0) :- !.
spaces(N) :- write(' '), N1 is N - 1, spaces(N1).

pp([H|T], I) :- !, J is I + 3, pp(H,J), ppx(T, J), nl.
pp(X,1) :- spaces(I), write(X), nl.

ppx([],_).
ppx([H|T], I) :- pp(H,I), ppx(T,I).

/* second arg of pp is the column counter. So to display a list would be pp(L,0)*/
