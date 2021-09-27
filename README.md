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
      4.  for arithmetic
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

   10. Satisfying goals
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
       8. Unification. `?- sum(2+3).` unifies with *fact* `sum(X + Y).` : the argument of the sum structure is a structure with + sign as its functor and 2 and 3 as its components so X is instantiated to 2 and Y is instantiated to 3.
          1. Compare with computation using `is` predicate: `?- X is 2 + 3.`
          2. verbosely `add(X, Y, Z) :- Z is X + Y.`