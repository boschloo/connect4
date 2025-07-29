% c4_v715_terminal_las.lp
% Learning terminal/0.
% ASP-code for playing Connect Four.
% Version to be used in the learning process

% Background knowledge -------------------------------------------------------
board_size(7,6).
col(X) :- X = 1..M, board_size(M,N).
row(Y) :- Y = 1..N, board_size(M,N).

% Roles / players -------------------------------------------------------------
role(1). role(2).

% Player in control -----------------------------------------------------------
control(V1) :- numberOf(V1,V3); numberOf(V2,V3); V1 < V2.
control(V1) :- numberOf(V1,V2); numberOf(V4,V3); V2 < V3.

% Additional concepts --------------------------------------------------------
open(V1) :- cell(V1,V2-1,0).
open :- cell(V1,V2,0).

% Game state update  ---------------------------------------------------------- 
target(V1,V2,V3) :- cell(V1,V2,0); does(V3,drop(V1)); not cell(V1,V2-1,0).

% Legal moves: Actions --------------------------------------------------------
legal(V1,drop(V2)) :- control(V1); cell(V2,V3,0).

% Game state update  ---------------------------------------------------------- 
next(V1,V2,V3) :- target(V1,V2,V3).
next(V1,V2,V3) :- control(V4); cell(V1,V2,V3); not target(V1,V2,V4).
next(control(V1)) :- role(V1); not control(V1).

% Goal -------------------------------------------------------------------------
goal(V1,100) :- line(V1).
goal(V1,50) :- role(V1); not goal(V1,100); not goal(V1,0).
goal(V1,0) :- role(V1); V2 != V1; goal(V2,100).

% Line  -------------------------------------------------------------------------
dia1(V1,V2,V3) :- cell(V1,V2,V3); cell(V1+1,V2+1,V3); cell(V1+2,V2+2,V3); cell(V1+3,V2+3,V3).
horz(V1,V2,V3) :- cell(V1,V2,V3); cell(V1+1,V2,V3); cell(V1+2,V2,V3); cell(V1+3,V2,V3).
dia2(V1,V2,V3) :- cell(V1,V2,V3); cell(V1+1,V2-1,V3); cell(V1+2,V2-2,V3); cell(V1+3,V2-3,V3).
vert(V1,V2,V3) :- cell(V1,V2,V3); cell(V1,V2+1,V3); cell(V1,V2+2,V3); cell(V1,V2+3,V3).

line(P) :- horz(X,Y,P). 
line(P) :- vert(X,Y,P). 
line(P) :- dia1(X,Y,P). 
line(P) :- dia2(X,Y,P).

% Termination ---------- TO BE LEARNED -----------------------------------------
% terminal :- line(P).
% terminal :- not open.

#modeh(terminal).

#modeb(2, role(var(r))).
#modeb(1, control(var(r))).
#modeb(1, line(var(r))).
#modeb(1, open).
#modeb(1, open(var(x))).
% #modeb(1, var(r) != var(r)).
% #modeb(3, cell(var(x),var(y),var(r))).
% #modeb(1, target(var(x),var(y))).
% #modeb(1, legal(var(r),drop(var(x)))).
% #modeb(2, cell(var(x),var(y),var(r))).
% #modeb(2, cell(var(x),var(y),const(c))).
% #modeb(2, cell(var(x),var(y),0)).
% #modeb(2, cell(var(x),var(y)-1,0)).
% #modeb(1, drop(var(x))).
% #modeb(1, does(var(r), drop(var(x)))).

maxv(3).

#pos({ },{terminal},{
cell(1,6,0). cell(2,6,0). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,0). cell(7,6,0).
cell(1,5,0). cell(2,5,0). cell(3,5,0). cell(4,5,0). cell(5,5,0). cell(6,5,0). cell(7,5,0).
cell(1,4,0). cell(2,4,0). cell(3,4,0). cell(4,4,0). cell(5,4,0). cell(6,4,0). cell(7,4,0).
cell(1,3,0). cell(2,3,0). cell(3,3,0). cell(4,3,0). cell(5,3,0). cell(6,3,0). cell(7,3,0).
cell(1,2,0). cell(2,2,0). cell(3,2,0). cell(4,2,0). cell(5,2,0). cell(6,2,0). cell(7,2,0).
cell(1,1,0). cell(2,1,0). cell(3,1,0). cell(4,1,0). cell(5,1,0). cell(6,1,0). cell(7,1,0).
}).

% . . . . . . .
% . . . . . . .
% . . . . . . .
% . . . . . . .
% . . . . . . .
% . . . . . . .

#pos({terminal},{},{
cell(1,6,1). cell(2,6,1). cell(3,6,1). cell(4,6,2). cell(5,6,1). cell(6,6,1). cell(7,6,1).
cell(1,5,2). cell(2,5,2). cell(3,5,2). cell(4,5,1). cell(5,5,2). cell(6,5,2). cell(7,5,2).
cell(1,4,1). cell(2,4,1). cell(3,4,1). cell(4,4,2). cell(5,4,1). cell(6,4,1). cell(7,4,1).
cell(1,3,2). cell(2,3,2). cell(3,3,2). cell(4,3,1). cell(5,3,2). cell(6,3,2). cell(7,3,2).
cell(1,2,1). cell(2,2,1). cell(3,2,1). cell(4,2,2). cell(5,2,1). cell(6,2,1). cell(7,2,1).
cell(1,1,2). cell(2,1,2). cell(3,1,2). cell(4,1,1). cell(5,1,2). cell(6,1,2). cell(7,1,2).
}).

% 1 1 1 2 1 1 1
% 2 2 2 1 2 2 2
% 1 1 1 2 1 1 1
% 2 2 2 1 2 2 2
% 1 1 1 2 1 1 1
% 2 2 2 1 2 2 2

#pos({},{terminal},{
cell(1,6,0). cell(2,6,1). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,0). cell(7,6,0).
cell(1,5,0). cell(2,5,2). cell(3,5,0). cell(4,5,0). cell(5,5,1). cell(6,5,0). cell(7,5,0).
cell(1,4,0). cell(2,4,1). cell(3,4,0). cell(4,4,1). cell(5,4,2). cell(6,4,0). cell(7,4,2).
cell(1,3,0). cell(2,3,2). cell(3,3,2). cell(4,3,2). cell(5,3,1). cell(6,3,0). cell(7,3,2).
cell(1,2,0). cell(2,2,2). cell(3,2,2). cell(4,2,2). cell(5,2,1). cell(6,2,1). cell(7,2,1).
cell(1,1,1). cell(2,1,1). cell(3,1,1). cell(4,1,2). cell(5,1,1). cell(6,1,1). cell(7,1,2).
}).

% . 1 . . . . .
% . 2 . . 1 . .
% . 1 . 1 2 . 2
% . 2 2 2 1 . 2
% . 2 2 2 1 1 1
% 1 1 1 2 1 1 2

#pos({terminal},{},{
cell(1,6,0). cell(2,6,1). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,0). cell(7,6,0).
cell(1,5,0). cell(2,5,2). cell(3,5,0). cell(4,5,0). cell(5,5,1). cell(6,5,0). cell(7,5,0).
cell(1,4,0). cell(2,4,1). cell(3,4,0). cell(4,4,1). cell(5,4,2). cell(6,4,0). cell(7,4,2).
cell(1,3,0). cell(2,3,2). cell(3,3,2). cell(4,3,2). cell(5,3,1). cell(6,3,0). cell(7,3,2).
cell(1,2,2). cell(2,2,2). cell(3,2,2). cell(4,2,2). cell(5,2,1). cell(6,2,1). cell(7,2,1).
cell(1,1,1). cell(2,1,1). cell(3,1,1). cell(4,1,2). cell(5,1,1). cell(6,1,1). cell(7,1,2).
}).

% . 1 . . . . .
% . 2 . . 1 . .
% . 1 . 1 2 . 2
% . 2 2 2 1 . 2
% 2 2 2 2 1 1 1
% 1 1 1 2 1 1 2

% terminal :- not open.
% terminal :- role(V1); line(V1).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Pre-processing                          : 0.025s
% %% Hypothesis Space Generation             : 0.026s
% %% Counterexample search                   : 0.02s
% %%   - CDOEs                               : 0s
% %%   - CDPIs                               : 0.019s
% %% Hypothesis Search                       : 0.037s
% %% Total                                   : 0.107s
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%