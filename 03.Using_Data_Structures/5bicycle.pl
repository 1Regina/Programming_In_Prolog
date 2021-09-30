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

/* RULES
partsof take a list of compoenents parts ie the Subpart AND then find the partsof of each element in Subparts. Hence, it call itself to get partsof for the tail of list. Since there is resulting different lists, partsoflist use append to glue the lists together */
partsof(X, P) :-
    assembly(X, Subparts),
    partsof(Subparts, P).

partsoflist([], []).
partsoflist([P|Tail], Total) :-
    partsof(P, Headparts),
    partsof(Tail, Tailparts),
    append(Headparts, Tailparts, Total).

/* recall append (reserved property) */
% append([], L, L).
% append([X|L1], L2, [X|L3]) :- append(L1, L2, L3).


/* for grammar and sentences */
aseembly(sentence, [noun_phrase, verb_phrase]).
assembly(noun_phrase, [determiner, noun]).
assembly(determiner, [the]).
assembly(noun, [apple]).
assembly(noun, [fruit]).

basicpart(apple).
basicpart(fruit).

/* regina for grammar */
aseembly(verb_phrase, [verb, adverb]).
assembly(verb,[is]).
assembly(adverb,[here]).
basicpart(is).
basicpart(here).