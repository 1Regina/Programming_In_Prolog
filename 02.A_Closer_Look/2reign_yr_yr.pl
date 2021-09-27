/* facts on prince reign period*/
reigns(rhodri, 844, 878).
reigns(anarawd, 878, 916).
reigns(hywei_dda, 916, 950).
reigns(lago_ap_idwal, 950, 979).
reigns(hwel_ap_ieuaf, 979, 985).
reigns(cadwallon, 985, 986).
reigns(maredudd,986,999).

/* rule */
/* prince X reign in year Y if it fulfils the fact reigns(X, A, B) */
prince(X, Y) :-
    reigns(X, A, B),
    Y >= A,
    Y =< B.
