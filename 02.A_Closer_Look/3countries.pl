/* facts */
pop(usa, 203).
pop(india, 548).
pop(china, 800).
pop(brazil, 108).

area(usa, 3).
area(india, 1).
area(china, 4).
area(brazil, 3).

/*
rule for population (pop) density for a country :
    The population density of country X is Y, if:
            The population of X is P, and
            The area of X is A, and
            Y is calculated by dividing P by A.
*/
density(X, Y) :-
    pop(X, P),
    area(X, A),
    Y is P / A .