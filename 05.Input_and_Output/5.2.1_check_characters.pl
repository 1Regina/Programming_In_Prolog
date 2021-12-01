check_line(OK) :-
        get_char(X),
        rest_line('\n', X, OK).

rest_line(_, '\n', yes) :- !.
rest_line(Last, Current, no) :-
    typing_error(Last, Current), !,
    get_char(New),
    rest_line(Current, New, _).
rest_line(_, Current, OK) :-
    get_char(New),
    rest_line(Current, New, _).
rest_line(_, Current, OK) :-
    get_char(New),
    rest_line(Current, New, OK).
typing_error('q', 'w').
typing_error('c', 'v').

/* correct_line and typing_correction are better version than the above */
/* correct_line correct a known typing error when it is detected otherwise the characters are simply copied out unchanged */

correct_line :-
    get_char(X),
    correct_rest_line('\n', X).
correct_rest_line(C, '\n') :-!,
    put_char(C), nl.
correct_rest_line(Last, Current) :-
    typing_correction(Last, Current, Corr), !,
    get_char(New).
    correct_rest_line(Corr, New).
correct_rest_line(Last, Current) :-
    put_char(Last),
    get_char(New),
    correct_rest_line(Current, New).
typing_correction('q','w','q').
typing_correction('c','v','c').

/* Read in a sentence */
read_in([W|Ws]) :- get_char(C), readword(C, W, C1), restsent(W, C1, Ws).

/* Given a word and the character after it, read in the rest of the sentence */
restsent(W, _, []) :- lastword(W), !.
restsent(W, C, [W1|Ws]) :- readword(C, W1, C1), restsent(W1, C1, Ws).

/* Read in a single word, given an initial character, and remembering which character came after the word. */
readword(C, C, C1) :- single_character(C), !, get_char(C1).

readword(C, W, C2) :-
    in_word(C, NewC),
    !,
    get_char(C1),
    restword(C1, Cs, c2),
    atom_chars(W, [NewC|Cs]).
readword(C, W, C2) :- get_char(C1), readword(C1, W, C2).
restword(C, [NewC| Cs], C2) :-
        in_word(C, NewC),
        !,
        get_char(C1), restword(C1, Cs, C2).
restword(C, [], C).

/* These characters can appear within a word. The second in_word clause converts letters to lower-case */

lin_word(C, C) :- letter(C, _). /* a b...z */
lin_word(C, L) :- letter(L, C). /* A B...Z */
lin_word(C, C) :- digit(C). /* 1 2...9 */
lin_word(C, C) :- special_character(C). /* '.' */

/* Special characters */
special_character('-').
special_character("").

/* These characters form words on their own */
single_character(',').
single_character('.').
single_character(';').
single_character(':').
single_character('?').
single_character('!').

/* Upper and lower case letters */
letter(a, 'A').
letter(b, 'B').
letter(c, 'C').
letter(d, 'D').
letter(e, 'E').
letter(f, 'F').
letter(g, 'G').
letter(h, 'H').
letter(i, 'I').
letter(j, 'J').
letter(k,'K').
letter(l,'L').
letter(m,'M').
letter(n,'N').
letter(o,'O').
letter(p,'P').
letter(q,'Q').
letter(r,'R').
letter(s,'S').
letter(t,'T').
letter(u,'U').
letter(v,'V').
letter(w,'W').
letter(x,'X').
letter(y,'Y').
letter(z,'Z').


