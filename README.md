1. Overview
   1. To run after installing, go to directory with the `.pl` file and `swipl likes.pl` (where likes.pl is name of file)
      1. `?- likes(joe,money).`  to produce boolean answer
      2. `?- owns(john, book(_, author(_, bronte))).` to produce boolean answer if john owns a book by a author with bronte surname.
      3. `?- owns(john, book(X, author(Y, bronte))).` to produce answers for who is the X and who is the Y?
      4. `?- likes(john,X).`  to produce what john likes.
      5. <Ctrl><d> to quit
      6. <Enter> after answer means happy with 1 answer
      7. To have more answers like uninstantiated variables outcome, hit `;`
      8. if <Enter> before fullstop, next line is | so to complete the query, insert `.`
      9. comment out with `/* .... */` (see 01.Tutorial_Introduction/sister.pl)  and can also be used to number /*1*/ (see 01.Tutorial_Introduction/steal.pl )
   2. Additional material https://www.swi-prolog.org/pldoc/man?section=quickstart
2. Ch01 Tutorial Introduction
   1. Rules
      1. usually oversimplified & accepted as definitions e.g sisters = 2 females with same parents
   2. Prolog is a storehouse of facts and rules which it uses to answer questions. Prolog requires
      1. specifying some *facts* about objects and their relationships
      2. defining some *rules* about objects and their relationships
      3. asking *questions* about objects and their relationships
   3. Facts
      1. relationships + objects in lower case. likes (john, mary). = john likes mary
      2. 1st r/s then 2nd objects with commas.
      3. must have full stop
      4. arbitrary order but must be consistent
      5. many ways to interpret a name as determined by the programmer.
      6. names in bracket = arguments  vs relationship before bracket = predicate
      7. e.g valuable (gold). vs likes (john, mary). valuable = predicate with 1 argument vs likes = predicate with 2 arguments.
      8. Collection of facts (and / rules) = database
   4. Questions
      1. with ?- e.g ?- owns(mary, book) = Does Mary own the book?
      2. *unify* Answers in Prolog is found by searching through the database for facts that *unify* the fact in the question , meaning
         1. predicates are same
         2. arguments are the same
         3. then answer = yes
   5. Variables
      1. To list all the possibilies e.g whatever John like
      2. `X` for objects yet to be named.
      3. instantiated variable = known object
      4. uninstantiated variable = unknown object
      5. Variable start with capital letter
      6. After a variable is found, we say it is instantiated (here to book)
         ```
            ?- likes(john,X).
            X = book .
         ```
      7. Conjugation
         1. **and**
            1. to ask *each other* type question , use `,` e.g do john and mary like each other: `?- likes(john,mary),likes(mary,john).` Note. If many conditions, just extend with more `,`.
            2. to ask common variable object questions like what do mary and john like in common: `?- likes(mary,X),likes(john,X).`
            3. Process. started with code line 16 in 01.Tutorial_Introduction/likes.pl
               1. When a goal is satisfied, Prolog mark the place in database in case there is need to re-satisfy ie instantiated first likes(mary,chocolate). and chocolate is marked everywhere in the database
               2. Then the second part looks for likes(john,chocolate). in the database but this is not found.
               3. So Prolog looks for next likes(mary,X). but starting from where it was marked previously ie likes(mary,chocolate). and make X uninstantiated once more so that X may unify with anything. This means uninstantiating all the chocolate
               4. Now, it tries til it get the next unifying fact likes(mary,wine). Prolog marks wines in case it must re-satisfy what mary likes later.
               5. Again, Prolog goes trying for the second goal ie likes(john,wine). As it is not re-satisfying the goal as it is an extension from the LHS, it starts from the start of database until the unifying fact is found n goal is satisfied so it marks its place in case there is need to re-satisfy the goal.
               6. Answer is where both goals have been satisfied. First goal X rest at wine at the database fact likes(mary,wine). and the second goal rest and make a place-marker at the database fact likes(john,wine).
               7. To find the second item that both john and mary like with `;` to re-satisfy both goals starting from the place-markers they rested at previously.
               8. Prolog satisfy goal from left to right, passing each `,`
               9. See *backtracking* in book: forgetting the previous instantiated X that satisfy the first goal bcos it cannot be instantiated / match for the second goal. And re-attempt to re-satisfy the first goal of likes(mary,X).
      8. Rules
         1. Compact way than a list of facts e.g John likes every one (in the data base) is tedious. Rule form: John likes any object provided it is a person.
         2. Consistent interpretation. In a rule, if 1 X stands for Fred, then all X = Fred. But at each different rule, a variable can stand for different object.
         3. A rule is a general statement about objects and their relationships.
         4. `:-` means **if** and is to connect head and body bcos a rule consists of a head and a body.
         5. Adding conditions. Compare
            ```
               likes(John, X) :- likes(X, wine), likes (X, food).  gives John likes anyone who likes wine AND food
               likes(John, X) :- female(X), likes(X, wine).        gives John likes a woman who likes wine
            ```
         6. Can be more than a tuple. parents(X, Y, Z). means The parents of X are Y (for mother) and Z (for father)
         7. Can be singular. male(albert).
         8. So sisters can be written as
            ```
               sister_of(X,Y) :-
                  female(X),
                  parents(X, M, F),
                  parents(Y, M, F).
            ```
         9. *conferences* each variable refers to the other. As soon as 1 is instantiated, the other becomes instantiated to the same objected. So for 01.Tutorial_Introduction/sister.pl after loading, `?- sister_of(alice,X).` in terminal will return `X = edward `
         10. Typically, a predicate is defined by a mixture of facts and rules ie *clauses* for a predicate. So *clause* is either a fact or a rule. Example  the rule `may_steal` depends on clauses `thief` and `likes`
            ```
               may_steal(P,T) :- thief(P), likes (P,T)
            ```
         11. For  example,  in  the  may_steal  rule in 01.Tutorial_Introduction/steal.pl,  X  stands  for the  object  that  can  steal  something. But in the likes rule, X stands for the object that is liked. In order for this program to make sense, Prolog must be able to tell that X can stand for two different things  in  two  different uses  of the clauses.
            ```
               likes(john,X) :- likes(X, wine).
               may_steal(X,Y) :- thief(X), likes(X,Y).

            ```
3. Ch02 A Closer Look
   1. Prolog allows ways to structure data + the order in which attempts are made to satisfy goals.
   2. Prolog programs are built from *terms*. A term is either a *constant*, a *variable*, or a *structure* and term = sequence of characters.
   3. 4 forms of characters
      1. Capital letters
      2. Lower case letters
      3. Numerals
      4. Signs and Symbols
   4. Terms
      1. **Constants** name specific object or specific relationships. 2 kinds:
         1. atoms:
            1. names given e.g likes mary john book can_steal wine
            2. `?-` (for questions) and `:-` (rules)
         2. number with e = power of 10 such that -2.67e2 = -2.67 x 10 x 10
      2. **Variables** starts with
         1. capital letters
         2. or an under sign "_" e.g `?- likes(_,john). Allow anonymous variables in the same clause to be given different interpretations.
      3. **Structures** = a single object consisting of a collection of other objects, called components which are *related*.
         1. The related components are grouped together into a single structure for convenience in handling them. A libary card with author name, title, publication date, location etc is an example of structure bcos it contains components e.g author name which further consist of initials and surname.
         2. Context of structure is given by specifying the structure *functor* and its *components*.
         3. Below example the book structure inside the fact ie as an argument, it is an object, taking part in a relationship. Another structure for author's name to distinguish among 3 Bronte writers to allow for QA using variables where X is instantiated to title and then Y will be instantiated to the first name. Alternatively, QA can be done with anonynmous "_" to get true/false answer if john owns any book by a bronte author.
            ```
               owns(john, book(wuthering_heights, author(emily, bronte))).

               ?- owns(john, book(X, author(Y, bronte))).

               ?- owns(john, book(_, author(_, bronte))).
            ```
         4. A predicate (used in facts and rules) is actually the functor of a structure.
         5. The arguments of a fact or rule are actually the components of a structure.
   5. **Characters** may be
      1. printable : displayable
      2. non-printable: non displayable e.g new line
   6. Operators
      1. " x + y *z " is `+(x, *(y,z)).`
      2. 3 + 4 is `+(3,4)` which is a data structure.
      3. left vs right associative. +-*/ are left associative so 8/4/4 = (8/4)/4 and 5+8/2/2 = 5+((8/2)/2)
   7. Unification.
      1. When X = Y and Y = something , then X is also equal the same thing. X = the structure rides(student,bicycle) by `?- rides(student,bicycle) = X`
      2. atoms and integers only equal to themselves.
      3. 2 structures are equal if
         1. same functor
         2. same number of components
         3. all corresponding components are equal
      4. X = Y means they refer to the same thing ie they *co-refer*
            ```
            equal(X, Y) :- X = Y
            ```
   8. Arithmetic

      | notation  	| meaning  	                           |
      |---	         |---	                                 |
      | X =:=Y  	   | X and Y stand for the same number   	|
      | X =\=Y  	   | X and Y stand for different number 	|
      | X < Y  	   | X is less than Y                    	|
      | X > Y 	      | X is greater than Y               	|
      | X =< Y      	| X is less than or equal to Y        	|
      | X >= Y     	| X is greater than or equal to Y     	|
   9. `is` operator:
      1.  infix
      2.  right side is an arithmetic expression
      3.  so if left is unknown, then all the right variables must be known to evaluate.
      4. for arithmetic
         ```
            /*   rule for population (pop) density for a country :
               The population density of country X is Y, if:
                        The population of X is P, and
                        The area of X is A, and
                        Y is calculated by dividing P by A.
            */
            density(X, Y) :-
               pop(X, P),
               area(X, A),
               Y is P / A .
         ```
      5. `is` supports:

         | notation  	| meaning  	                              |
         |---	         |---	                                    |
         | X + Y  	   | the sum of X and Y   	                  |
         | X - Y  	   | the difference of X and Y         	   |
         | X * Y  	   | the product of X and Y              	   |
         | X / Y 	      | the quotient of X divided by Y      	   |
         | X // Y      	| the integer quotient of X divided by Y 	|
         | X mod Y     	| the remainder of X divided by Y        	|

   10.  Satisfying goals
       1.  *conjunction* of goals to be satisfied
       2. via the known *clauses* e.g *fact* or a *rule* to reduce the task to that of satisfying a conjugation of *subgoals*
       3. if a gaol is not satisfied, *backtracking* will be initiated to *re-satisfy* the goals to find alterative way to satisfy the goals.
       4. can self-initate backtracking by `;`
       5. Start with satisfying the left then move to satisfy the right
       6. boxes illustration Fig 2.4:
          1. Arrow moves down the page, passing through the boxes.
          2. Enter a box, a clause is chosen and its position marked.
          3. If the clause unifies with the goal and the clause is a **fact**, then the arrow can leave the box.
          4. Else if the clause unifies with the goal and the clause is a rule, then new boxes are created for the subgoals. The aarow must pass through all these subgoal boxes before leaving the original big box.
       7. Backtracking for failure (bcos alternatives have been tried or bcos `;`), the arrows retreat back into the boxes that have previously been left in order to re-satisfy the goals.
          1. first uninstantiated all variables previously instantiated while satisfying the goal.
          2. searches through the database from where the place-marker was put. When it finds another unifying possibility, it marks the place and recontinue from 6 above.
          3. Further failure leads to further arrow retreats until it comes to another place-marker, while reset previous choices to uninstantiated.
          4. Prolog searches through the database for a clause after the place marker. A new place marker is recorded if it finds a clause that unifies with the goal. Boxes for subgoals are created and arrows starts moving downwards again. Otherwise arrows continue retreating upwards to find another place marker.
   11. Unification. `?- sum(2+3).` unifies with *fact* `sum(X + Y).` : the argument of the sum structure is a structure with + sign as its functor and 2 and 3 as its components so X is instantiated to 2 and Y is instantiated to 3.
          1. Compare with computation using `is` predicate: `?- X is 2 + 3.`
          2. verbosely, the rule can be written as `add(X, Y, Z) :- Z is X + Y.`
4. Ch03 Using Data Structures
   1. head is the first element in a list and tail is the remaining elements
   2. `|` as in `([X|Y])` instantiated X to the head and Y to the tail.
   3. With 03.Using_Data_Structures/1list.pl, test `|`
      ```
         ?- p([X|Y]).
         X = 1,
         Y = [2, 3] ;
         X = the,
         Y = [cat, sat, [on, the, mat]].

         ?- p([_,_,_,[_|X]]).
         X = [the, mat].

         ?- p([_,_,_,[A|X]]).
         A = on,
         X = [the, mat].
      ```
   4. Recursion case here has 2 boundary conditions -- either existent or not in the list
      1. First boundary condition is first clause to cause the search through the list to be stopped if the first argument of member matches the head of the second argument.
      2. Second boundary condition is when the second argument of member is the empty list. ie complete search to the end already.
         ```
            /* Fact: X as a member of the list that has X as its head */
            member(X, [X|_]).
            /* As a rule alternatively*/
            member(X, [Y|_]) :- X = Y.
            /* recursion : X is a member of the list if X is a member of the tail of the list*/
            member(X, [_|Y]) :- member(X,Y).

         ```
      3. Be careful about
         1. ending with "circular definition". chicken and egg problem
            ```
               parent(X, Y) :- child(Y, X).
               child(A, B)  :- parent (B, A).

            ```
         2. Where subgoal relies on another goal which is the subgoal which run until memory runs out.
            ```
               person(adam).
               person(X) :- person(Y), mother(X, Y).

               AND QUESTION IS
               ?- person(X).

               SOLUTION is put rule before fact.
               person(X) :- person(Y), mother(X, Y).
               person(adam).

            ```
      4. Try to put rule before fact: see solution to issue 2 above except for when exceptional tail must be empty list case
            ```
               SOLUTION is put rule before fact.
               person(X) :- person(Y), mother(X, Y).
               person(adam).

               EXCEPTION
               islist([A|B]) :- islist(B).
               islist([]).

            ```
   5. Mapping (refer to 03.Using_Data_Structures/2translate.pl)
      1. definition: traverse the old structure component by component and construct the components of the new structure. ie retain old structure but with some modification.
      2. in Dialog example (03.Using_Data_Structures/2translate.pl) Change 'do' to 'no', 'french' to 'german', and 'you' to 'I' for "do you speack french?" to return "no i speak german"
      3. So translation is actually altering a list with head H and tail T gives a list with head X and tail Y if:
         1. changing word H gives word X, and
         2. altering the list T gives the list Y.
      4. Translation involve database of many facts `change(X,Y).` **and** a *catchall* fact
      5. first clause check for empty list. and also for end of of list as well
         1. Example
            ```
               alter([], []).
               alter([H|T],[X,Y]) :- change(H, X), alter(T, Y).

               ?- alter([you, are, a, computer], Z).
               Z = [i, [[am, not], [a, [computer, []]]]]
            ```
         2. First step
            1. H is "you"
            2. T is [are, a, computer]
         3. Translate with goal `change(you,X).` from the facts in 03.Using_Data_Structures/2translate.pl so X is "i". As X is the head of output list in `alter([H|T],[**X**,Y])`, the first word in utput list is "i".
         4. Next phase goal alter([are, a, computer], Y) follows the same rule with "are" being translate by `change(are, [am, not]).` such that `are` becomes the list `[am, not]` by the database.
         5. This eventually leaves us with `alter([a, computer], Y).`
            1. Searching through the database for `change(a, X)` without success leads to the catchall fact `change(X, X)` so "a" remains "a"
            2. Return to `alter` rule again with `computer` as head of input list and `[]` as tail of input list.
            3. `change(computer,X)` matches with the catchall.
            4. Finally `alter` is called with the empty list `[]` which matches the first alter clause `alter([], []).` resulting in an empty list thus ending the sentence. (rem a list ends with an empty tail).
         6. Put together prologs responds with `Z = [i, [[am, not], [a, [computer, []]]]] ` or `Z = [i, [am, not], a, computer]`.
         7. Interesting notes:
            1. `[am, not]` is in the output list. It is essentially an example of a list that is a member of another list.
            2. boundary conditions occurs when
               1. fact `alter([], []).` for when input list becomes empty list , then terminate the output list by putting an empty list at its end, and
               2. catchall `change(X, X).` for when all the change facts have been combed through, then retain the word unchanged by changing it into itself.
   6. Recursive Comparison (See 03.Using_Data_Structures/3compare_car.pl)
      1. First create a predicate fuel_consumed for car with list of fuel consumption over 4 routes in their order.
         ```
            fuel_consumed(waster, [3.1, 10.4, 15.9, 10.3]).
            fuel_consumed(guzzler, [3.2, 9.9, 13.0, 11.6]).
            fuel_consumed(prodigal, [2.8, 9.8, 13.1, 10.4]).
         ```
      2. The comparison predicate `equal_or_better_consumption` to compare 2 consumption with underlying yardstick -- consumption is equal or better" if less than 5% more than the ave of the two. So the threshold is 1/20 of the average or 1/40 of the sum.
         ```
            equal_or_better_consumption(Good, Bad) :-
            Threshold is (Good + Bad) / 40,
            Worst is Bad + Threshold,
            Good < Worst.
         ```
      3. Rule to compare 2 cars based on their fuel consumption that over each of the 4 routes, it beats the relative car.
         ```
            prefer(Car1, Car2):-
            fuel_consumed(Car1, Con1),
            fuel_consumed(Car2, Con2),
            always_better(Con1, Con2).
         ```
      4. A rule to compare consumption for 2 cars across each corresponding element across the list of 4 routes.
         1. Code rules
            ```
               always_better([], []).
               always_better([Con1|T1], [Con2|T2]) :-
                  equal_or_better_consumption(Con1, Con2),
                  always_better(T1, T2).
            ```
         2. `always_better([Con1|T1], [Con2|T2])` means first list is always better if its head `Con1` is equal or better consumption that the comparative head `Con2` and plus its tail of first list `T1` is always better than the tail of the comparative list `T2`.
         3. Above is recursion: Test heads of 2 lists, then the 2 heads via second layer/element of remaining lists, then 3rd pair of heads of the original lists which is the remaining lists of last 2 routes. This continues until all 4 corresponding elements in 2 respective lists are compared, each time invoking recursion.
         4. When the boundary condition fails ie `equal_or_better_consumption` fails, the original `always_better` goal will fail also.
      5. Subtly different from `always_better` is `sometimes_better`. `sometimes_better` achieve boundary condition when an element in first list is a better consumption than corresponding element in the second list. ie succeed without going any further down the list. Note that at least 1 pair of elements needs to be better otherwise the predicate would fail bcos both both clauses specify non-empty lists in both arguments.
         ```
            sometimes_better([Con1|_],[Con2|_]) :-
               equal_or_better_consumption(Con1, Con2).
            sometimes_better([_|Con1], [_|Con2]) :-
               sometimes_better(Con1, Con2).

         ```
      6. Ex 3.1 A significant better consumption comparison. See 03.Using_Data_Structures/3compare_car.pl :
         ```
         significant_better_consumption(Good, Bad) :-
            Good < Bad ,
            Margin is (abs(Bad - Good)) * 2,
            Good < (4 * Margin).

         significant_better([Con1|_],[Con2|_]) :-
            significant_better_consumption(Con1, Con2).
         significant_better([_|Con1], [_|Con2]) :-
            significant_better(Con1, Con2).

         ```
         1. Test with
            ```
               ?- significant_better_consumption(4,5).
               true.
               ?- significant_better_consumption(4.8,5).
               false.
               ?- significant_better_consumption(2,10).
               true.

            ```
         2. Within expectation
            ```
               /* bcos 2nd head is true */
               ?- significant_better([4.8,1,4.5] ,[5,5,5]).
               true

               /* bcos 1st head is true */
               ?- significant_better([1 ,4.8, 4.5 ], [5 ,5, 5 ]).
               true

               /* bcos none is true */
               ?- significant_better([5 ,4.8, 4.5 ], [5 ,5, 5 ]).
               false.
            ```
   7. Joining Structures Together
      1. Definition of `append` 2 lists into 1 list:
         ```
            append([], L, L).
            append([X|L1], L2, [X|L3]) :- append(L1, L2, L3).

            /* returns */
            ?- append([alpha, beta], [gamma, delta], X).
            X = [alpha, beta, gamma, delta].

            ?- append(X, [b, c, d], [a,b,c,d]).
            X = [a]
         ```
         1. Boundary condition is when first list is empty list. Then what returns is the appended list.
         2. Second rule has 3 principles:
            1. Head of first list ie `X` will become the head of the 3rd list.
            2. Second argument `L2` will append to tail of first list (`L1`) to form/become tail of the 3rd argument `L3`.
            3. Pt 2 is perform via the recursive append.
            4. Continually take head of remaining tail from first argument until it becomes empty list ie until the boundary condition `append([], L, L).` occurs.
      2. Like the bicycle parts in 03.Using_Data_Structures/5bicycle.pl and hierachical tree, partsoflist can be applied to generate sentences from a grammar after decomposition into noun phrase, verb phrase, determiner.
   8. Accumulator
      1. Len of list without accumulator:
         ```
            listlen([],0).
            listlen([H|T], N) :- listlen(T, N1), N is N1 + 1.
         ```
         1. 2 clauses: the boundary condition and the recursive case
         2. Boundary condition = empty list has length 0.
         3. Recursive case with rule that the length of non-empty list is computed by adding 1 to length of the tail of the list.
      2. With accumulator
         ```
            /* format */
            lenacc(L, A, N).

            listlen(L, N) :-
               lenacc(L, 0, N).

            lenacc([], A, A).
            lenacc([H|T], A, N) :-
               A1 is A + 1,
               lenacc(T, A1, N).
         ```
         1. `lenacc([], A, A).` For empty list, the length is whatever has been accumulated so far (A).
         2. Second clause `A1 is A + 1 ` increase accumulation by 1 to become `A1`. Then recur on the tail with `A1` .
         3. Sequence for list [a, b, c, d, e]:
            1. lenacc([a, b, c, d, e], 0, N)
            2. lenacc([b, c, d, e], 1, N)
            3. lenacc([c, d, e], 2, N)
            4. lenacc([d, e], 3, N)
            5. lenacc([ e], 4, N)
            6. lenacc([], 5, N)
            7. activate boundary condition lenacc([], A, A).
            8. N becomes instantiated to 5 as N = A as A = 5.
      3. Bicycle parts with accumulator 03.Using_Data_Structures/7accum_bicycle.pl vs 5bicycle.pl
         1. `partsacc`
            ```
               /* NEW */
               /* with accumulator */
               partsof(X, P) :-
                  partsacc(X, [], P).

               partsacc(X, A, [X|A]) :-
                  basicpart(X).

               /* partsacc is similar to 5bicycle.pl partsof except for accumulator
               partsacc (X, A, P) means the parts of object X, when added to the list A, gives the list P. */

               partsacc(X, A, P) :-
                  assembly(X, Subparts),
                  partsacclist(Subparts, A, P).

            ```
            1. first clause of `partsacc(X, A, [X|A]) :- basicpart(X).` construct a new list with head being the first argument `X` and tail being the accum list of parts. Condition is object is a basic part.
            2. second clause of `partsacc(X, A, P) :- assembly(X, Subparts),  partsacclist(Subparts, A, P).` is applicable for objects which are assembly. 1st find the list of subparts, then apply `partsacclist` to find subparts of each part in the list
         2. `partsacclist`
            ```
               /* partsacclist is similar to 5bicycle.pl partsoflist except for accumulator*/
               partsacclist([], A, A).
               partsacclist([P|Tail], A, Total) :-
                  partsacc(P, A, Hp),
                  partsacclist(Tail, Hp, Total).
            ```
            1. first clause `partsacclist([], A, A).` is the boundary case which is result of accumulated list of subparts (A).
            2. second clause `partsacclist([P|Tail], A, Total) :- partsacc(P, A, Hp), partsacclist(Tail, Hp, Total).` The recursive case call `partsacc` to find subparts of next eleemnt on the given list. Recursive goal deals with the remainder of the list.
            3. Second clause 2nd argument (`A`) becomes the accumulator for the `partsacc` goal to give result `Hp` which becomes the accumulator for the recursive goal.
      4. Side effect with accumulator is the output list is in reverse order to the original list. For bicycle parts, this reversal is ok but it is not ok for English sentences. Bcos for every basic part, a new accumulator is created which has this part appending to to the end of list `.... partsacclist(Tail, Hp, Total).`.
   9. **Difference lists** to overcome accumulator order reversal problem with 2 arguments
      1.  one argument for "result so far"
      2.  one argument for "hole where further info can be plugged into for final result"
         ```
            [a, b, c|X] X
         ```
      3. With a plug hole to sequence the result in order:
         ```
            /* Changes with plug hole to ensure accumulator results is not reversed */
            partsof(X, P) :-
               partsacc(X, P, Hole), Hole = [].
               /* alternatively partsacc(X, P , []). */

            partsacc(X, [X| Hole], Hole) :-
               basicpart(X).
            partsacc(X, P, Hole) :-
               assembly(X, Subparts),
               partsacclist(Subparts, P, Hole).

         ```
         1. `partsof` clause: `partsacc` is called only once by `partsof`, instantiate the `Hole` with [] to terminate the difference list. This `partsacc(X, P, Hole), Hole = [].` means that the very last hole will be filled with `[]` even before the list contents are known.
         2. `partsacc` first clause returns a *difference list* with the object `X` as first argument if it is a basic part.
         3. `partsacc` second clause is for assemblies. It
            1. find the `subparts` list
            2. delegate traversal of list to `partsacclist`, passing the 2 requistie arguments making the difference -- `P` and `Hole`. This in turn use `partsacc` (specficially `... partsacc(P, Total, Hole1),` in `partsacclist` to list subparts using the difference list via `Total` and `Hole1`.
            3. while still on `partsacclist` which was extended from `partsacc` , `partsacclist(T, Hole1, Hole).` is essentially the recursive goal to return the portion of difference list starting at `Hole` and ending at `Hole`.
            4. Result: list between `Total` and `Hole` is result of second `partacclist` clause "weaving" together partial results. ![Alt text](03.Using_Data_Structures/differenceList.png?raw=true "Traversal in partacclist - Difference List (ordered accumulator)") <p align="center"> Traversal in partacclist - Difference List (ordered accumulator) </p>
5. Ch04 Backtracking and the "Cut"
   1. Multipple solutions
      ```
         /* Dance Party */
         possible_pair(X, Y) :- boy(X), girl(Y).

         boy(john).
         boy(marmaduke).
         boy(bertram).
         boy(charles).

         girl(griselda).
         girl(ermintrude).
         girl(brunhilde).

         ?- possible_pair(X,Y).
         X = john,
         Y = griselda ;
         X = john,
         Y = ermintrude ;
         X = john,
         Y = brunhilde ;
         X = marmaduke,
         Y = griselda ;
         X = marmaduke,
         Y = ermintrude ;
         X = marmaduke,
         Y = brunhilde ;
         X = bertram,
         Y = griselda ;
         X = bertram,
         Y = ermintrude ;
         X = bertram,
         Y = brunhilde ;
         X = charles,
         Y = griselda ;
         X = charles,
         Y = ermintrude ;
         X = charles,
         Y = brunhilde.
      ```
      1. Prolog produces solutions in this order bcos
         1. first satisty the goal boy(X) ie John, then the girl(Y) ie griselda.
         2. With `;` for backtracking, Prolog attemps to  re-satisfy the girl goal to satisfy the possible_pair goal. This brings us to to girl ermintrude giving the pair john and ermintrude as 2nd solution.
         3. Eventually at john and brunhilde, the place-marker is at the the end of database and the next time, the goal fails. Now it tries to re-satisfy boy(X). Since the place-marker was earlier placed at the first boy fact, the next solution would be the second boy marmaduke.
         4. Upon satisfying the second boy for the boy goal, Prolog attempts to satifsy the girl(Y) goal from the start again ,ie griselda the first girl. So the next 3 solution is marmaduke and the 3 different girls.
         5. On the following attempt, girl goal cannot be re-satisfied again and we find another boy and begin search for girl from scratch.
         6. At the end, no more solution for girl goal and no more solution for boy goal such that the program cannot find anymore pairs.
   2. The "Cut"
      1. tells Prolog which previous choice it needs not consider again when it backtracks through the chain of satisfied goals. (Save memory and time).
      2. Note this suceeds immediately and cannot be re-satisfied. (side-effects)
      3. "Cut" alters the flow of satisfaction ![Alt text](04.Backtracking_and_the_Cut/cut.png?raw=true "The Cut alters the flow of satisfaction") <p align="center"> Cut limits the facility to basic facility out of all available facilities (general and basic) </p>
      4. "Cut" changes the flow of satisfaction path so as to avoid all the place markers between the facility goal (comprising "basic" and "additional") and the cut goal("basic") inclusive. Thus if backtracking later retreat past this point, the facility goal will immediately fail. Result: alternative solutions for goal *book_overdue('A. Jones', Book).*
      5. Summary effect: If there is overdue book, only the basic facilities is available to the client. No need to go through all the overdue books nor any other rules about facilities.
      6. When a cut is encountered as a goal, commitment is made only to all choices made since parent goal (the `!` box) was invoked. All other alternatives are discarded such that attempt to re-satisfy goal between parent goal and cut goal will fail.
      7. In `foo` , Prolog will backtrack among goals a, b, and c until the success of c causes the "fence" to be crossed to the right to reach goal d. Then backtracking can occur among d,e, and f, maybe safisfying the entire conjunction several times. But if d fails, the "fence" is crossed to the left, then no attempt will be made to re-satisfy goal c: the entire conjunction of goals fail and the goal `foo` also fail.
         ```
            foo :- a, b, c, !, d, e, f.
         ```
   3. "Cut" uses
      1. Right rule found for a particular goal. The "cut" says "if you get this far, you have picked the correct rule for this goal."
      2. For telling the systems where to fail a particular goal immediately so it won't try for alternative solutions. "Stop trying if you get to here."
      3. To terminate backtracking looking for alternative solutions. "If you get to here, you have found the only solution to this problem, no point ever looking for alternatives."
   4. "Cut" example
      1. Recursive example
         ```
            sum_to(1,1) : !.
            sum_to(N, Res) :-
               N1 is N - 1,
               sum_to(N1, Res1),
               Res is Res1 + N.
         ```
         1. first clause = boundary condition for 1 where result is also 1.
         2. second clause = recusion where new goal is 1st argument is one less again until boundary condition is reached.
         3. Prolog will try to match the number agst 1 first and try the second rule if this fails ie the second rule are for non-1 numbers. But actually both rules allows for `sum_to(1, X).` so we need to specify in first rule a "cut" to say never remake decision about which rule to use for sum_to goal ie only get this far with number = 1
         4. Ex 4.1 Using the above, the program will run into an infinite loop as it toggle between first and second clause for N = 1 SO it needs a condition. The improved solution is
            ```
               sum_to(N,1) :- N =< 1, !.
               sum_to(N, R) :-
                  N1 is N - 1,
                  sum_to(N1, R1),
                  R is R1 + N.

            ```
            1. When condition is true, go for 1st clause and no more recursive goals. If false, then go for second clause. (Cut purpose)
      2. *only if* with `\+` . `\+X` succees only if X, when seen as a Prolog goal fails. ie `\+X` means that "X is not satisfiable as a Prolog goal." Two alternative for when X is not 1:
         ```
            /* more alternatives with \+X for X is not satisable */
            /* OPTION 1 with \+ */
            sum_to(1,1).
            sum_to(N,R) :-
               \+(N = 1),
               N1 is N-1,
               sum_to(N1, R1),
               R is N + R1.

            /* OPTION 2 with \+ */
            sum_to(N,1) :- N =< 1.
            sum_to(N,R) :-
               \+(N =< 1),
               N1 is N - 1,
               sum_to(N1, R1),
               R is N + R1.
         ```
         1.  More replacement options
             1.  `\+(N=1)` can be replaced by `N\=1`
             2.  `\+(N=<1)` can be replaced by `N>1`
         2. `\+` are preferred over cuts as they are easier to understand. But need to ensure `\+` involves showing that it is a satisfiable goal.
         3. Weigh against complexity to use `\+` or `!`
            1. Hard to understand and may even end up satisfying B twice for `B` and `\+ B`
               ```
                  A :- B, C.
                  A :- \+B, D.
               ```
            2. Easier to understand incidentally with cut
               ```
                  A :- B, !, C.
                  A :- D.
               ```
      3. Cut can make more sense esp when appending empty list to front of another list for **efficiency reasons**.
            1. This is inefficient bcos of backtracking to satisfy append([],[a,b,c,d],X) goal.
               ```
                  appennd([], X, X).
                  append([A|B], C, [A|D]) :- append (B,C,D).
               ```
            2. This cut improves efficiency
               ```
                  appennd([], X, X) :- !.
                  append([A|B], C, [A|D]) :- append (B,C,D).

               ```
   5. **cut-fail combination** Fail means the goal always fail and causes backtracking, similar to trying to satisfy a goal for a predicate with no facts or rules. To stop finding alternatives bcos RECALL: during BACKTRACKING, Prologs tries to re-satisfy **EVERY** goal that has suceeded. **Insert a cut (to freeze the ddecision) before failing** See 04.Backtracking_and_the_Cut/taxpayer.pl.
         1. goal for someone being an average taxpayer can be abandoned if the spouse earns more than 3000
            ```
               average_taxpayer(X) :-
               spouse(X, Y),
               gross_income(Y, Inc),
               Inc > 3000,
               !, fail.
            ```
         2. if pernsion is < P, then the person has no gross income
            ```
               gross_income(X, Y) :-
               gross_salary(X, Z),
               investment_income(X, W),
               Y is Z + W.
            ```
   6. Call predicate **`\+`**: treats argument as goal to satisfy it. Below means for first rule to be applicable it P can be shown and second to be applicable otherwise.
      ```
         \+P :- call(P), !, fail.
         \+P.
      ```
      1. ie If Prolog can satisfy call(P), it should thereupon abandon satisfying the \+ goal.
      2. OTHERWISE if it cannot show call(P), then it never gets to the cut. Bcos the call(P) goal fail, hence backtracking begins and Prolog finds the second rule. This results in goal \+P succeeding when P (indicated by call(P)) is not provable.
   7. Terminate a "generate and test"
      1. "Generate": process of generating acceptable solutions(success) during backtracking (vs when no more solutions can be found(failure)).
      2. "Test" : checking whether the alternative solution(s) generated is acceptable.
      3. In 04.Backtracking_and_the_Cut/tic_tac_toe.pl
         ```
            line(b(X,Y,Z,_,_,_,_,_,_),X,Y,Z). /* top row */
            line(b(_,_,_,X,Y,Z,_,_,_),X,Y,Z). /* second row */
            line(b(_,_,_,_,_,_,X,Y,Z), X,Y,Z).
            line(b(X,_,_,Y,_,_,Z,_,_),X,Y,Z).
            line(b(_,X,_,_,Y,_,_,Z,_),X,Y,Z).
            line(b(_,_,X,_,_,Y,_,_,Z),X,Y,Z).
            line(b(X,_,_,_,Y,_,_,_,Z),X,Y,Z).
            line(b(_,_,X,_,Y,_,Z,_,_),X,Y,Z).

            /* Case where x-player is threatening to win on next move */
            /* cut means 1 threat is enough to force a move */
            forced_move(Board) :-
               line(Board,X,Y,Z),
               threatening(X,Y,Z),
               !.

            threatening(e,x,x).
            threatening(x,e,x).
            threatening(x,x,e).
         ```
         1. program tries to find a line with 2 occupied squares and report a forced_move situation.
         2. In forced_move, the goal of line(Board,X,Y,Z) is the "generator" of possible lines which has many possibilities.
         3. In forced_move, the "tester" goal is threatening(X,Y,Z) which looks for 1 of 3 possible threatening patterns.
         4. Thus the sequence is:
            1. line propose a line
            2. threatening check if line is threatening. If forced, forced_move goal succeed.
            3. otherwise, backtracking kicks in to find another line.
            4. If we get to the point when line can generate no more lines, then forced_move goal correctly fails ie no forced move.
         5. But mostly, there is no alternative so save on effort for forced_move to search thru before itself failing. So put a "cut" at the end of forced_move.  EFFECT is freeze the last successful line solution. This means when looking for forced moves, only the first solution is important.
      4. In 04.Backtracking_and_the_Cut/4.3.3b_divide.pl, the result of dividing 27 by 6 is 4 bcos 4 * 6 is less than or equal to 27, and 5 * 6 is greater than 27.
         ```
            divide(N1, N2, Result) :-
            is_integer(Result),
            Product1 is Result * N2,
            Product2 is (Result + 1) * N2,
            Product1 =< N1, Product2 > N1,
            !.
         ```
         1. generator =  `is_integer`
         2. tester = rest of goals bcos for specific N1, N2, `divide(N1, N2, Result)` can only succeed for 1 possible value for Result.
         3. so although `is_integer` can generate infinitely many candidates, the tester will limit solution to 1. And the cut purpose is to stop trying after we have a `Result` that passes the test.
         4. The cut stop backtracking from finding alternatives for `is_integer`.
      5. Cut problem. Putting cut at the wrong place could give a wrong result ie no solution when there are. So it is impt to be certain how the rules work. p96 shows
         1. Freezing everything saying no further solutions altho there are actually other solutions.
            ```
               append([], X, X) : -!.
               append([A|B], C, [A|D]) :- append(B,C,D).

               ?- append(X, Y, [a,b,c]).
               will return
               X = [], Y= [a,b,c] only.
            ```
         2. 04.Backtracking_and_the_Cut/4.4_cut_problem.pl is intended to say everyone has 2 parents expect adam and eve. The cut prevents backtracking to 3rd rule of the person(X) being adam or eve. See tge 2 options as alternative.
         3. summary: review all the uses of cut to see the rules are used correctly.