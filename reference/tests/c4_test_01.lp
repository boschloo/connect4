% c4_test_001.lp

% Test 1 ===========================================================
% Background facts, initial game state

#show board_size/2.
#show col/1.
#show row/1.
#show role/1.
#show init/3.
#show init/1.

% Expected: 
% board_size as given, all cells content init/3 0.

% Result:
% clingo version 5.4.0
% Reading from /Users/boschloo/c4/c4_test_v301.lp
% Solving...
% Answer: 1
% col(1) col(2) col(3) col(4) col(5) col(6) col(7) 
% init(control(1)) 
% role(1) role(2) 
% row(1) row(2) row(3) row(4) row(5) row(6) 
% board_size(7,6) 
% init(1,6,0) init(2,6,0) init(3,6,0) init(4,6,0) init(5,6,0) init(6,6,0) init(7,6,0)
% init(1,5,0) init(2,5,0) init(3,5,0) init(4,5,0) init(5,5,0) init(6,5,0) init(7,5,0) 
% init(1,4,0) init(2,4,0) init(3,4,0) init(4,4,0) init(5,4,0) init(6,4,0) init(7,4,0)
% init(1,3,0) init(2,3,0) init(3,3,0) init(4,3,0) init(5,3,0) init(6,3,0) init(7,3,0)
% init(1,2,0) init(2,2,0) init(3,2,0) init(4,2,0) init(5,2,0) init(6,2,0) init(7,2,0) 
% init(1,1,0) init(2,1,0) init(3,1,0) init(4,1,0) init(5,1,0) init(6,1,0) init(7,1,0) 
% .... (7 answers)
% SATISFIABLE

% . . . . . . .
% . . . . . . .
% . . . . . . .
% . . . . . . .
% . . . . . . .
% . . . . . . .

% Models       : 7
% Calls        : 1
% Time         : 0.003s (Solving: 0.00s 1st Model: 0.00s Unsat: 0.00s)
% CPU Time     : 0.003s

% Evaluation: ok.

% === R E F E R E N C E   P R O G R A M ===== 2025-07-19 =====================
board_size(7,6).
role(1). role(2).

col(X) :- X = 1..M, board_size(M,N).
row(Y) :- Y = 1..N, board_size(M,N).

% Initial state --------------------------------------------------------------
init(X,Y,0) :- col(X), row(Y). 
init(control(1)).

% Initializing a game --------------------------------------------------------
cell(X,Y,P) :- init(X,Y,P).
control(P) :- init(control(P)).

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

