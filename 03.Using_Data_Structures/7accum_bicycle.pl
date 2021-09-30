/* FACTS basic parts and assembly */
/* Basic parts are not made up of any smaller parts. They are however combine with other basic parts to form assemblies. */
basicpart(rim).
basicpart(spoke).
basicpart(rearframe).
basicpart(handles).
basicpart(gears).
basicpart(bolt).
basicpart(nut).
basicpart(fork).

/* assembly is formed by aseembly name, then list of different basic parts by their quantity*/
assembly(bike, [wheel, wheel, frame]).
aseembly(wheel, [spoke, rim, hub]).
assembly(frame, [rearframe, frontframe]).
assembly(frontframe, [fork, handles]).
aseembly(hub, [gears, axle]).
assembly(axle, [bolt, nut]).

/* without accumulator original from 5bicycle.pl */
% partsof(X, P) :-
%     assembly(X, Subparts),
%     partsof(Subparts, P).

/* NEW */
/* with accumulator */
partsof(X, P) :-
    partsacc(X, [], P).

partsacc(X, A, [X|A]) :-
    basicpart(X).

/* partsacc is similar to 5bicycle.pl partsof except for accumulator
partsacc (X, A, P) means the parts of object X, when added to the list A, gives the list P. ie accumulates parts */
partsacc(X, A, P) :-
    assembly(X, Subparts),
    partsacclist(Subparts, A, P).



/* partsacclist is similar to 5bicycle.pl partsoflist except for accumulator*/
partsacclist([], A, A).
partsacclist([P|Tail], A, Total) :-
    partsacc(P, A, Hp),
    partsacclist(Tail, Hp, Total).

