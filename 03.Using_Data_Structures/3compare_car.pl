fuel_consumed(waster, [3.1, 10.4, 15.9, 10.3]).
fuel_consumed(guzzler, [3.2, 9.9, 13.0, 11.6]).
fuel_consumed(prodigal, [2.8, 9.8, 13.1, 10.4]).

/* yardstick: consumption is equal or better" if less than 5% more than the ave of the two. So the threshold is 1/20 of the average or 1/40 of the sum */

equal_or_better_consumption(Good, Bad) :-
    Threshold is (Good + Bad) / 40,
    Worst is Good + Threshold,
    Good < Worst.

prefer(Car1, Car2):-
    fuel_consumed(Car1, Con1),
    fuel_consumed(Car2, Con2),
    always_better(Con1, Con2).

/* recurse through every corresponding element in 2 lists */
always_better([], []).
always_better([Con1|T1], [Con2|T2]) :-
    equal_or_better_consumption(Con1, Con2),
    always_better(T1, T2).

/* subtly different from always_better. sometimes_better achieve boundary condition when an element in first list is a better consumption than corresponding element in the second list. ie succeed wtihout going any further down the list. */
sometimes_better([Con1|_],[Con2|_]) :-
    equal_or_better_consumption(Con1, Con2).
sometimes_better([_|Con1], [_|Con2]) :-
    sometimes_better(Con1, Con2).

/* Ex 3.1 create a program for car preference if one test result is significantly better */
significant_better_consumption(Good, Bad) :-
    Good < Bad ,
    Margin is (abs(Bad - Good)) * 2,
    Good < (4 * Margin).

significant_better([Con1|_],[Con2|_]) :-
    significant_better_consumption(Con1, Con2).
significant_better([_|Con1], [_|Con2]) :-
    significant_better(Con1, Con2).