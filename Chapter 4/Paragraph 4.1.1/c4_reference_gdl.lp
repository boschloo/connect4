% c4_reference_gdl.lp
% ASP-code for playing Connect Four.
% Version according to GDL-standards
%

board_size(7,6).

% Roles / players-------------------------------------------------------------
role(1). role(2).

% == RULES =========================================================================
col(X) :- X = 1..M, board_size(M,N).
row(Y) :- Y = 1..N, board_size(M,N).

% Initial state --------------------------------------------------------------
init(cell(X, Y, 0)) :- col(X), row(Y). 
init(control(1)).

% Legal moves: Actions --------------------------------------------------------------
legal(P, drop(X)) :- true(control(P)), open(X), not terminal.

% Action selection -----------------------------------------------------------
{does(X, A): legal(X, A)} = 1 :- not terminal. 

% Game state update  --------------------------------------------------------- 
target(X,Y,P) :- does(P, drop(X)), true(cell(X,Y,0)), not true(cell(X,Y-1,0)).
next(cell(X,Y,P)) :- true(cell(X,Y,P)), role(P).
next(cell(X,Y,P)) :- target(X,Y,P).
next(cell(X,Y,0)) :- true(cell(X,Y,0)), not target(X,Y,_).

next(control(2)) :- true(control(1)).
next(control(1)) :- true(control(2)). 

% Goal -----------------------------------------------------------------------
goal(P,100) :- line(P).
goal(P, 50) :- not goal(P,100), not goal(P,0), role(P).
goal(P,  0) :- goal(P2,100), P!=P2, role(P).

% Termination ----------------------------------------------------------------
terminal :- line(P).
terminal :- not open.

% Additional concepts --------------------------------------------------------
open(X) :- true(cell(X, N, 0)), col(N).
open :- open(X).
 
horz(X,Y,P) :- true(cell(X,Y,P)), true(cell(X+1,Y,P)), true(cell(X+2,Y,P)), true(cell(X+3,Y,P)), role(P).
vert(X,Y,P) :- true(cell(X,Y,P)), true(cell(X,Y+1,P)), true(cell(X,Y+2,P)), true(cell(X,Y+3,P)), role(P).
dia1(X,Y,P) :- true(cell(X,Y,P)), true(cell(X+1,Y+1,P)), true(cell(X+2,Y+2,P)), true(cell(X+3,Y+3,P)), role(P).
dia2(X,Y,P) :- true(cell(X,Y,P)), true(cell(X+1,Y-1,P)), true(cell(X+2,Y-2,P)), true(cell(X+3,Y-3,P)), role(P).

line(P) :- horz(X,Y,P). 
line(P) :- vert(X,Y,P). 
line(P) :- dia1(X,Y,P). 
line(P) :- dia2(X,Y,P).

#show init/1.