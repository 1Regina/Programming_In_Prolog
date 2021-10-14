% sum_to(1,1) : !.
% sum_to(N, Res) :-
%     N1 is N - 1,
%     sum_to(N1, Res1),
%     Res is Res1 + N.

/* with cut  to ensure not continous loop */

% sum_to(N,1) :- N =< 1, !.
% sum_to(N, R) :-
%     N1 is N - 1,
%     sum_to(N1, R1),
%     R is R1 + N.

/* more alternatives with \+X for X is not satisable */
/* OPTION 1 with \+ */
sum_to(1,1).
sum_to(N,R) :-
    \+(N = 1),
    N1 is N-1,
    sum_to(N1, R1),
    R is N + R1.

/* OPTION 2 with \+ */
% sum_to(N,1) :- N =< 1.
% sum_to(N,R) :-
%     \+(N =< 1),
%     N1 is N - 1,
%     sum_to(N1, R1),
%     R is N + R1.
