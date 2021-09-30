/* list length without accumulator */
listlen([],0).
listlen([H|T], N) :-
    listlen(T, N1),
    N is N1 + 1.


/* list length with accumulator
L for length,
A for accumulating number
N for the number */
lenacc(L, A, N).

/* initiate by making A = 0 */
listlen(L, N) :-
    lenacc(L, 0, N).

lenacc([], A, A).
lenacc([H|T], A, N) :-
    A1 is A + 1,
    lenacc(T, A1, N).
