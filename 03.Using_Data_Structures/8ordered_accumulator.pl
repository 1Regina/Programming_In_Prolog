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

/* Changes with plug hole to ensure accumulator results is not reversed */
partsof(X, P) :-
    partsacc(X, P, Hole), Hole = [].
   /* alternatively partsacc(X, P , []). */

partsacc(X, [X| Hole], Hole) :-
    basicpart(X).
partsacc(X, P, Hole) :-
    assembly(X, Subparts),
    partsacclist(Subparts, P, Hole).

partacclist([], Hole, Hole).
partsacclist([P|T], Total, Hole) :-
    partsacc(P, Total, Hole1),
    partsacclist(T, Hole1, Hole).

