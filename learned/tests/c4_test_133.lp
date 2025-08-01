% c4_test_133.lp 
% testing opponent/2.

#show opponent/2.
#show does/2.

% Test 133 - partially, one full column, opponent -----------------------------------------

cell(1,6,0). cell(2,6,0). cell(3,6,0). cell(4,6,0). cell(5,6,1). cell(6,6,0). cell(7,6,0).
cell(1,5,0). cell(2,5,0). cell(3,5,0). cell(4,5,0). cell(5,5,1). cell(6,5,0). cell(7,5,1).
cell(1,4,0). cell(2,4,0). cell(3,4,2). cell(4,4,0). cell(5,4,2). cell(6,4,0). cell(7,4,2).
cell(1,3,0). cell(2,3,0). cell(3,3,2). cell(4,3,0). cell(5,3,1). cell(6,3,0). cell(7,3,1).
cell(1,2,0). cell(2,2,2). cell(3,2,1). cell(4,2,0). cell(5,2,2). cell(6,2,1). cell(7,2,2).
cell(1,1,2). cell(2,1,2). cell(3,1,1). cell(4,1,0). cell(5,1,1). cell(6,1,1). cell(7,1,2).

% . . . . 1 . .
% . . . . 1 . 1
% . . 2 . 2 . 2
% . . 2 . 1 . 1
% . 2 1 . 2 1 2
% 2 2 1 . 1 1 2

% Solving...
% Answer: 1
% opponent(2,1) opponent(1,2) does(1,drop(2))
% Optimization: 40 20 20
% Answer: 2
% opponent(2,1) opponent(1,2) does(1,drop(4))
% Optimization: 20 0 0
% OPTIMUM FOUND

% === L E A R N E D  P R O G R A M  ======== 2025-07-27 =========================
role(1). role(2).
col(X) :- cell(X,_,_).
row(Y) :- cell(_,Y,_).

% NumberOf/2 given ------------------------------
count(1,0,P,0) :- role(P).
count(X,Y,P,N) :- count(X,Y-1,P,N-1), cell(X,Y,P).
count(X,1,P,N) :- count(X-1,Y-1,P,N-1), not cell(X-1,Y,_), cell(X,1,_), cell(X,1,P).
count(X,Y,P,N) :- count(X,Y-1,P,N), cell(X,Y,_), not cell(X,Y,P).
count(X,1,P,N) :- count(X-1,Y-1,P,N), not cell(X-1,Y,_), cell(X,1,_), not cell(X,1,P).
numberOf(P,N) :- count(X,Y,P,N), board_size(X,Y).

% Action selection given ========================
{does(X, A): legal(X, A)} = 1 :- not terminal. 

% Board_size v705 ------------------------------- 
greaterY(V1) :- row(V1); row(V2); V2 > V1.
greaterX(V1) :- col(V1); col(V2); V2 > V1.
board_size(V1,V2) :- col(V1); row(V2); not greaterX(V1); not greaterY(V2).

% Row-of-four v700, v701, v702, v703-------------
horz(V1,V2,V3) :- role(V3); cell(V1,V2,V3); cell(V1+1,V2,V3); cell(V1+2,V2,V3); cell(V1+3,V2,V3).
vert(V1,V2,V3) :- role(V3); cell(V1,V2,V3); cell(V1,V2+1,V3); cell(V1,V2+2,V3); cell(V1,V2+3,V3).
dia1(V1,V2,V3) :- role(V3); cell(V1,V2,V3); cell(V1+1,V2+1,V3); cell(V1+2,V2+2,V3); cell(V1+3,V2+3,V3).
dia2(V1,V2,V3) :- role(V3); cell(V1,V2,V3); cell(V1+1,V2-1,V3); cell(V1+2,V2-2,V3); cell(V1+3,V2-3,V3).

% line v711 -------------------------------------
line(V1) :- horz(V2,V3,V1).
line(V1) :- vert(V2,V3,V1).
line(V1) :- dia1(V2,V3,V1).
line(V1) :- dia2(V2,V3,V1).

% control v704 ----------------------------------
control(V1) :- numberOf(V1,V3); numberOf(V2,V3); V1 < V2.                  
control(V1) :- numberOf(V1,V2); numberOf(V4,V3); V2 < V3.   

% open v717 ------------------------------------
open(V1) :- cell(V1,V2-1,0).
open :- cell(V1,V2-1,0).

% target/2 v706, v716 ---------------------------
target(V1,V2) :- cell(V1,V2,0); not cell(V1,V2-1,0).                       
target(V1,V2,V3) :- cell(V1,V2,0); does(V3,drop(V1)); not cell(V1,V2-1,0).  

% legal v711 ------------------------------------
legal(V1,drop(V2)) :- control(V1); cell(V2,V3,0); not terminal.      

% opponent v708b --------------------------------
opponent(V1,V2) :- role(V1); role(V2); V2 != V1.                            

% next v710, v718 --------------------------------
next(V1,V2,V3) :- cell(V1,V2,V3); not cell(V1,V2,0).    
next(V1,V2,V3) :- cell(V1,V2,V3); cell(V1,V2-1,0).
next(V1,V2,V3) :- cell(V1,V2,0); does(V3,drop(V1)); not cell(V1,V2-1,0).
next(V1,V2,0) :- control(V3); cell(V1,V2,0); not does(V3,drop(V1)).
next(control(V1)) :- role(V1); control(V2); not control(V1).

% goal v713 -------------------------------------
goal(V1,100) :- line(V1).
goal(V1,50) :- role(V1); not terminal.
goal(V1,0) :- role(V1); V2 != V1; goal(V2,100).

% terminal v715 ---------------------------------
terminal :- not open.
terminal :- role(V1); line(V1).

% Checks given ------------------------------
% Vertical
check(P,X) :- cell(X,Y,P), cell(X,Y+1,P), cell(X,Y+2,P), cell(X,Y+3,0), role(P).

% Horizontal
check(P,X) :- cell(X,Y,0), cell(X+1,Y,P), cell(X+2,Y,P), cell(X+3,Y,P), target(X,Y), role(P). % .ooo
check(P,X) :- cell(X-1,Y,P), cell(X,Y,0), cell(X+1,Y,P), cell(X+2,Y,P), target(X,Y), role(P). % o.oo 
check(P,X) :- cell(X-2,Y,P), cell(X-1,Y,P), cell(X,Y,0), cell(X+1,Y,P), target(X,Y), role(P). % oo.o 
check(P,X) :- cell(X-3,Y,P), cell(X-2,Y,P), cell(X-1,Y,P), cell(X,Y,0), target(X,Y), role(P). % ooo.

% diagonal SW-NE
check(P,X) :- cell(X,Y,0), cell(X+1,Y+1,P), cell(X+2,Y+2,P), cell(X+3,Y+3,P), target(X,Y), role(P).  
check(P,X) :- cell(X-1,Y-1,P), cell(X,Y,0), cell(X+1,Y+1,P), cell(X+2,Y+2,P), target(X,Y), role(P). 
check(P,X) :- cell(X-2,Y-2,P), cell(X-1,Y-1,P), cell(X,Y,0), cell(X+1,Y+1,P), target(X,Y), role(P).  
check(P,X) :- cell(X-3,Y-3,P), cell(X-2,Y-2,P), cell(X-1,Y-1,P), cell(X,Y,0), target(X,Y), role(P). 

% diagonal NW-SE
check(P,X) :- cell(X,Y,0),     cell(X+1,Y-1,P),  cell(X+2,Y-2,P), cell(X+3,Y-3,P), target(X,Y), role(P).  
check(P,X) :- cell(X-1,Y+1,P), cell(X,Y,0),      cell(X+1,Y-1,P), cell(X+2,Y-2,P), target(X,Y), role(P). 
check(P,X) :- cell(X-2,Y+2,P), cell(X-1,Y+1,P),  cell(X,Y,0),     cell(X+1,Y-1,P), target(X,Y), role(P).  
check(P,X) :- cell(X-3,Y+3,P), cell(X-2,Y+2,P),  cell(X-1,Y+1,P), cell(X,Y,0),  target(X,Y), role(P). 

% preferences v801 ------------------------------
:~ does(V1,drop(V2)), not center(V2).[20@1, V1, V2]
:~ does(V1,drop(V2)), not check(V1,V2).[20@2, V1, V2]
:~ does(V1,drop(V2)), role(V3), not check(V3,V2).[20@3, V1, V2, V3]

center(X) :- X > 2, X < 6, col(X).

% ===================================================================