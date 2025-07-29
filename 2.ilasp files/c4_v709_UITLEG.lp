% c4_v673_las.lp
% Learning next/3.
% ASP-code for playing Connect Four.
% Version to be used in the learning process

% Background knowledge -------------------------------------------------------
board_size(7,6).
col(X) :- X = 1..M, board_size(M,N).
row(Y) :- Y = 1..N, board_size(M,N).

% Roles / players -------------------------------------------------------------
role(1). role(2).

% Game state ------------------------------------------------------------------
cell(1,6,0). cell(2,6,0). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,2). cell(7,6,0).
cell(1,5,0). cell(2,5,0). cell(3,5,0). cell(4,5,2). cell(5,5,0). cell(6,5,1). cell(7,5,0).
cell(1,4,0). cell(2,4,0). cell(3,4,0). cell(4,4,1). cell(5,4,0). cell(6,4,2). cell(7,4,1).
cell(1,3,0). cell(2,3,0). cell(3,3,2). cell(4,3,2). cell(5,3,0). cell(6,3,2). cell(7,3,2).
cell(1,2,0). cell(2,2,1). cell(3,2,1). cell(4,2,1). cell(5,2,0). cell(6,2,1). cell(7,2,1).
cell(1,1,1). cell(2,1,2). cell(3,1,2). cell(4,1,1). cell(5,1,0). cell(6,1,2). cell(7,1,1).
control(2).
does(2,drop(1)).

% . . . . . 2 .
% . . . 2 . 1 .
% . . . 1 . 2 1
% . . 2 2 . 2 2
% . 1 1 1 . 1 1
% 1 2 2 1 . 2 1

% Additional concepts --------------------------------------------------------
open(V1) :- cell(V1,V2-1,0).
open :- cell(V1,V2-1,0).

% Game state update  ---------------------------------------------------------- 
target(V1,V2) :- cell(V1,V2,0); not cell(V1,V2-1,0).
target(X,Y,P) :- does(P, drop(X)), cell(X,Y,0), not cell(X,Y-1,0).

% Legal moves: Actions --------------------------------------------------------
legal(V1,drop(V2)) :- control(V1); target(V2,V3).

% Game state update  ----- TO BE LEARNED ------------------------------------ 
% next(X,Y,P) :- cell(X,Y,P), role(P).
% next(X,Y,P) :- target(X,Y,P).
% next(X,Y,0) :- cell(X,Y,0), not target(X,Y,_).

% Game state update  ----- LEARNED WITH NOTARGET ------  INCORRECT -----------          
% next(V1,V2,V3) :- cell(V1,V2,V3); cell(V1,V2-1,0).
% next(V1,V2,V3) :- cell(V1,V2,V3); not cell(V1,V2,0).
% next(V1,V2,V3) :- control(V4); cell(V1,V2,V3); not does(V4,drop(V1)).
% next(V1,V2,V3) :- cell(V4,V2,V3); does(V3,drop(V1)); not cell(V1,V2-1,0).

% Game state update  ----- LEARNED WITH TARGET ------  CORRECT -----------
% next(V1,V2,V3) :- target(V1,V2); does(V3,drop(V1)). 
% % pink - The target cell in the column used to drop gets the color of the player.
% next(V1,V2,V3) :- cell(V1,V2,V3); not target(V1,V2).% green 
% % green - All cells that are not a target keep the same content.
% next(V1,V2,V3) :- control(V4); cell(V1,V2,V3); not does(V4,drop(V1)).
% % blue - All columns where the player in control does not drop keep the same value.
% %.       The column where the player drops is not defined.       

% The rules test well but there is some overlap!

% next(V1,V2,V3) :- target(V1,V2,V3).
% next(V1,V2,V3) :- cell(V1,V2,V3); not target(V1,V2).
% next(V1,V2,0) :- control(V3); target(V1,V2); not does(V3,drop(V1)).

% % From c4_v671_las.lp
% next(V1,V2,V3) :- cell(V1,V2,V3).
% next(V1,V2,V3) :- target(V1,V2,V3).

% Dubbelt, target cell krijgt twee waarden! (5,1,2) en (5,1,0).

% % From c4_v672_las.lp

% next(V1,V2,V3) :- target(V1,V2,V3).
% % Target is the one cell that the player plays

% next(V1,V2,V3) :- cell(V1,V2,V3); not target(V1,V2).
% % All cells not a possible target/2 cell stay the same

% next(V1,V2,0) :- control(V3); target(V1,V2); not does(V3,drop(V1)). 
% % All target cells (legal actions) where player does not uses the column get a 0.

% From c4_v673_las.lp ---------- zonder target en legal

% next(V1,V2,0) :- cell(V1,V2-1,0).
% Als een onderliggende cel 0 is, dan 0. Dit is alles wat nu 0 is m.u.v. targetcellen.

% next(V1,V2,V3) :- cell(V1,V2,V3); not cell(V1,V2,0).
% Alle cellen die nu van een speler zijn houden de oude waarde

% next(V1,V2,V3) :- cell(V1,V2,0); does(V3,drop(V1)); not cell(V1,V2-1,0).
% De kolom waarin de speler dropt. De cel is 0, de onderliggende is niet 0. 
% Dit is dus de target cel, die krijgt de kleur van de speler.

% next(V1,V2,0) :- control(V3); cell(V1,V2,0); not does(V3,drop(V1)).
% Cellen in kolommen die 0 zijn en waarin de speler niet dropr 

% % Met een beperking op de aantal rijen:

% next(V1,V2,V3) :- cell(V1,V2,V3); not cell(V1,V2,0).
% % Alle cellen die nu van een speler zijn houden de oude waarde

% next(V1,V2,0) :- cell(V1,V2,V3); cell(V1,V2-1,0).
% % Blanco cellen met een blanco cel eronder blijven blanco

% next(V1,V2,0) :- control(V3); cell(V1,V2,0); not does(V3,drop(V1)). 

% next(V1,V2,V3) :- cell(V1,V2,0); does(V3,drop(V1)); not cell(V1,V2-1,0).
% % De cel is leeg, de cel eronder is niet leeg, de speler dropt in deze kolom: 1 nieuwe waarde

#show next/3.

% next(V1,V2,V3) :- cell(V1,V2,V3); cell(V1,V2-1,0). % Lege cellen met lege eronder
% next(V1,V2,V3) :- role(V3); cell(V1,V2,V3). % Oorspronkelijk gevulde cellen
% next(V1,V2,V3) :- cell(V1,V2,0); does(V3,drop(V1)); not cell(V1,V2-1,0). % Nieuwe zet
% next(V1,V2,0) :- control(V3); cell(V1,V2,0); not does(V3,drop(V1)). % Cellen in kolommen die 0 zijn en waarin de speler niet dropt 


% next(V1,V2,V3) :- cell(V1,V2,V3), not cell(V1,V2,0). % Oorspronkelijk gevulde cellen
%. next(V1,V2,0) :- cell(V1,V2-1,0); row(V2). % % Lege cellen met lege eronder
% next(V1,V2,0) :- control(V3); cell(V1,V2,0); not does(V3,drop(V1)).% Cellen in kolommen die 0 zijn en waarin de speler niet dropt 
% next(V1,V2,V3) :- does(V3,drop(V1)); row(V2); not cell(V1,V2-1,0). % Gevulde cellen in de dropcolumn

% Zonder gebruik van target
% next(V1,V2,V3) :- cell(V1,V2,V3); not cell(V1,V2,0). % Oorspronkelijk gevulde cellen
% next(V1,V2,V3) :- cell(V1,V2,V3); cell(V1,V2-1,0). % Lege cellen met lege eronder
% next(V1,V2,V3) :- cell(V1,V2,0); does(V3,drop(V1)); not cell(V1,V2-1,0). % Nieuwe zet
% next(V1,V2,0) :- control(V3); cell(V1,V2,0); not does(V3,drop(V1)). % Cellen in kolommen die 0 zijn en waarin de speler niet dropt , blijven leeg.

% Met gebruik van target
% Dit vind ik wel de mooiste.
next(V1,V2,V3) :- target(V1,V2,V3). % Target (1)
next(V1,V2,V3) :- role(V3); cell(V1,V2,V3). % Alle gevulde cellen (21)
next(V1,V2,0) :- control(V3); cell(V1,V2,0); not target(V1,V2,V3).% Alle cellen die 0 zijn en geen target. (20)
