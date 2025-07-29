% c4_test_06.lp

% Test 6  ==============================================================
% Board with diagonal line NW-SE in cell/3.

% . . . . . . .
% . . 2 2 . . .
% . . 1 2 . . .
% . 2 2 1 2 1 .
% 1 1 2 1 1 2 .
% 2 1 1 1 2 2 1

cell(1,6,0). cell(2,6,0). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,0). cell(7,6,0).
cell(1,5,0). cell(2,5,0). cell(3,5,2). cell(4,5,2). cell(5,5,0). cell(6,5,0). cell(7,5,0).
cell(1,4,0). cell(2,4,0). cell(3,4,1). cell(4,4,2). cell(5,4,0). cell(6,4,0). cell(7,4,0).
cell(1,3,0). cell(2,3,2). cell(3,3,2). cell(4,3,1). cell(5,3,2). cell(6,3,1). cell(7,3,0).
cell(1,2,1). cell(2,2,1). cell(3,2,2). cell(4,2,1). cell(5,2,1). cell(6,2,2). cell(7,2,0).
cell(1,1,2). cell(2,1,1). cell(3,1,1). cell(4,1,1). cell(5,1,2). cell(6,1,2). cell(7,1,1).
control(1).

#show line/1.
#show horz/3.
#show vert/3.
#show dia1/3.
#show dia2/3.
#show goal/2.
#show terminal/0.

% Expected: 
% terminal line(2) dia1(3,5,2), goal 0/100.

% Result:
% Answer: 1
% terminal line(2) goal(2,100) goal(1,0) dia2(3,5,2)
% SATISFIABLE

% Evaluation: ok.

% === R E F E R E N C E   P R O G R A M ===== 2025-07-19 ========================
board_size(7,6).
role(1). role(2).

col(X) :- X = 1..M, board_size(M,N).
row(Y) :- Y = 1..N, board_size(M,N).

% Initial state --------------------------------------------------------------
init(X,Y,0) :- col(X), row(Y). 
init(control(1)).

% Initializing a game --------------------------------------------------------
% cell(X,Y,P) :- init(X,Y,P).
% control(P) :- init(control(P)).

% Legal moves: Actions -------------------------------------------------------
legal(P, drop(X)) :- control(P), open(X), not terminal.

% Action selection -----------------------------------------------------------
{does(X, A): legal(X, A)} = 1 :- not terminal. 

% Game state update  --------------------------------------------------------- 
target(X,Y,P) :- does(P, drop(X)), cell(X,Y,0), not cell(X,Y-1,0).
next(X,Y,P) :- cell(X,Y,P), role(P).
next(X,Y,P) :- target(X,Y,P).
next(X,Y,0) :- cell(X,Y,0), not target(X,Y,_).

next(control(2)) :- control(1).
next(control(1)) :- control(2). 

% Goal -----------------------------------------------------------------------
goal(P,100) :- line(P).
goal(P, 50) :- not goal(P,100), not goal(P,0), role(P).
goal(P,  0) :- goal(P2,100), P!=P2, role(P).

% Termination ----------------------------------------------------------------
terminal :- line(P).
terminal :- not open.

% Additional concepts --------------------------------------------------------
open(X) :- cell(X,N,0), board_size(M,N).
open :- open(X).
 
horz(X,Y,P) :- cell(X,Y,P),cell(X+1,Y,P),cell(X+2,Y,P),cell(X+3,Y,P),role(P).
vert(X,Y,P) :- cell(X,Y,P),cell(X,Y+1,P),cell(X,Y+2,P),cell(X,Y+3,P),role(P).
dia1(X,Y,P) :- cell(X,Y,P),cell(X+1,Y+1,P),cell(X+2,Y+2,P),cell(X+3,Y+3,P),role(P).
dia2(X,Y,P) :- cell(X,Y,P),cell(X+1,Y-1,P),cell(X+2,Y-2,P),cell(X+3,Y-3,P),role(P).

line(P) :- horz(X,Y,P). 
line(P) :- vert(X,Y,P). 
line(P) :- dia1(X,Y,P). 
line(P) :- dia2(X,Y,P).

% ================================================================================

