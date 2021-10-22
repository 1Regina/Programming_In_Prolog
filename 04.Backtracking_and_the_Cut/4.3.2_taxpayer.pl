
average_taxpayer(X) :- foreigner(X), !, fail.

/* goal for someone being an average taxpayer can be abandoned if the spouse earns more than 3000*/
average_taxpayer(X) :-
        spouse(X, Y),
        gross_income(Y, Inc),
        Inc > 3000,
        !, fail.

average_taxpayer(X) :-
        gross_income(X, Inc),
        2000 < Inc, 20000 > Inc.

/* if pernsion is < P, then the person has no gross income */
gross_income(X, Y) :-
        receives_pension(X, P),
        P < 5000,
        !, fail.

gross_income(X, Y) :-
        gross_salary(X, Z),
        investment_income(X, W),
        Y is Z + W.

/* AN ALTERNATIVE REPRESENTATION OF THE ABOVE Taxpayer Program with all the enclosed condition but thats too many brackets */

% average_taxpayer(X) :-
%         \+foreigner(X),
%         \+((spouse(X,Y), gross_income(Y, Inc), Inc > 3000)),
%         gross_income(X, Inc1),
%         -
%         -
%         -