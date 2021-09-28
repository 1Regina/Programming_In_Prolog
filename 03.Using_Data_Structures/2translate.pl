change(you, i).
change(are, [am, not]). /* am , not in list so it occupies only 1 argument in fact */
change(french, german).
change(do, no).
change(X, X). /* this is the catchall */

alter([], []).
alter([H|T],[X,Y]) :- change(H, X), alter(T, Y).
