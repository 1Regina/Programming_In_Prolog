event(1505, ['Euclid', translated, into, 'Latin']).
event(1510, ['Reuchlin-Pfefferkorn', controversy]).
event(1523, ['Christian', 'II', flees, from, 'Denmark']).

/*goal when(X,Y) succeeds if X is mentioned in year Y*/
when(X,Y) :- event(Y, Z), member(X, Z).

% ?- when('Denmark', D).
% D = 1523.

hello1(Event) :- read(Date), event(Date, Event).