append([a, b, c], [3, 2, 1], [a, b, c, 3, 2, 1]).

/* append definition */
append([], L, L).
append([X|L1], L2, [X|L3]) :- append(L1, L2, L3).
