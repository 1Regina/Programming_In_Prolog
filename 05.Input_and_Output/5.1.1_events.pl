event(1505, ['Euclid', translated, into, 'Latin']).
event(1510, ['Reuchlin-Pfefferkorn', controversy]).
event(1523, ['Christian', 'II', flees, from, 'Denmark']).

/*goal when(X,Y) succeeds if X is mentioned in year Y*/
when(X,Y) :- event(Y, Z), member(X, Z).

% ?- when('Denmark', D).
% D = 1523.

hello1(Event) :- read(Date), event(Date, Event).

/* member is taken from 03.Using_Data_Structures/1list.pl*/
member(X, [X|_]).
/* As a rule alternatively*/
member(X, [Y|_]) :- X = Y.
/* recursion : X is a member of the list if X is a member of the tail of the list*/
member(X, [_|Y]) :- member(X,Y).



/* from 5.1.2_pretty_print.pl*/
/* to create spacing */
spaces(0) :- !.
spaces(N) :- write(' '), N1 is N - 1, spaces(N1).

/* for the coloumn counter ie indentation for embedded lists*
1st clause handles special case whereby first argument is a list*/
/* second arg of pp is the column counter. So to display a list would be pp(L,0)*/

pp([H|T], I) :- !, J is I + 3, pp(H,J), ppx(T, J), nl.
pp(X,I) :- spaces(I), write(X), nl.

ppx([],_).
ppx([H|T], I) :- pp(H,I), ppx(T,I).


/* pretty print headlines*/
phh([]) :- nl.
phh([H|T]) :- write(H), spaces(0), phh(T).


/*1. display question
  2. read to read the date like hello1
  3. phh to display the retrieved headline
  4. noticed the first phh shows it can display any list of atoms regardless of its origin
  ps: remember ' ' is for capital words to not mistaken them as Variable and bcos of ? at desire*/
hello2 :-
    phh(['What', date, do, you, 'desire? ']),
    read(D),
    event(D, S),
    phh(S).