/* helen has T1 20 cents and F1 fifty cents */
helen([T1,20], [F1,50]):-
    T1 is 64.

ivan([T2,20], [F2,50]):-
    T2 is 104.

/* helen T1 20 cents and F1 50 cents. ivan has T2 20 cents and F2 50 cents. Their individual coins qty are the same */
tally([T1, F1], [T2, F2]) :-
    T1 + F1 = T2 + F2,
    T1 is 64,
    T2 is 104.

/* weight of each coin */
weigh(W20,W50):-
    W50 is (W20 + 2.7).

/* Weight of Helen coins */
weigh(WT1, WF1) :-
    WT1 + WF1 is 1134.

/* Weight of Ivan coins */
weigh(WT2,WF2).