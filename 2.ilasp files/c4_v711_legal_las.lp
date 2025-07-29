% c4_v677_legal_las.lp
% Learning legal
% ASP-code for playing Connect Four.
% Version to be used in the learning process

% Background knowledge -------------------------------------------------------
board_size(7,6).
col(X) :- X = 1..M, board_size(M,N).
row(Y) :- Y = 1..N, board_size(M,N).

% Roles / players -------------------------------------------------------------
role(1). role(2).

% Game state ------------------------------------------------------------------


% . . . . . 2 .
% . . . 2 . 1 .
% . . . 1 . 2 1
% . . 2 2 . 2 2
% . 1 1 1 . 1 1
% 1 2 2 1 . 2 1

% Game state update  ---------------------------------------------------------- 
target(V1,V2) :- cell(V1,V2,0); not cell(V1,V2-1,0).

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

% Termination ----------------------------------------------------------------
terminal :- line(P).
terminal :- not open.

% Legal moves: Actions ---- TO BE LEARNED --------------------------------------
% legal(P, drop(X)) :- 

#modeh(legal(var(r), drop(var(x)))).

#modeb(1, role(var(r))).
#modeb(1, control(var(r))).
#modeb(2, cell(var(x),var(y),var(r))).
#modeb(1, col(var(x))).
#modeb(1, row(var(y))).
#modeb(2, cell(var(x),var(y),0)).
#modeb(2, cell(var(x),var(y)-1,0)).
#modeb(1, line(var(r))).
#modeb(1, dia1(var(x),var(y),var(r))).
#modeb(1, terminal).

#maxv(3).

#pos({
legal(2,drop(1)),legal(2,drop(2)),legal(2,drop(3)),legal(2,drop(4)),legal(2,drop(5)),legal(2,drop(7))  
},{
legal(1,drop(1)),legal(1,drop(2)),legal(1,drop(3)),legal(1,drop(4)),legal(1,drop(5)),legal(1,drop(6)),
legal(2,drop(6)),legal(1,drop(7))},
{ 
cell(1,6,0). cell(2,6,0). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,2). cell(7,6,0).
cell(1,5,0). cell(2,5,0). cell(3,5,0). cell(4,5,2). cell(5,5,0). cell(6,5,1). cell(7,5,0).
cell(1,4,0). cell(2,4,0). cell(3,4,0). cell(4,4,1). cell(5,4,0). cell(6,4,2). cell(7,4,1).
cell(1,3,0). cell(2,3,0). cell(3,3,2). cell(4,3,2). cell(5,3,0). cell(6,3,2). cell(7,3,2).
cell(1,2,0). cell(2,2,1). cell(3,2,1). cell(4,2,1). cell(5,2,0). cell(6,2,1). cell(7,2,1).
cell(1,1,1). cell(2,1,2). cell(3,1,2). cell(4,1,1). cell(5,1,0). cell(6,1,2). cell(7,1,1).
control(2).
}).

#pos({dia1(4,2,1)},{
legal(1,drop(1)),legal(1,drop(2)),legal(1,drop(3)),legal(1,drop(4)),legal(1,drop(5)),legal(1,drop(6)),legal(1,drop(7)),
legal(2,drop(1)),legal(2,drop(2)),legal(2,drop(3)),legal(2,drop(4)),legal(2,drop(5)),legal(2,drop(6)),legal(2,drop(7))
},{
cell(1,6,0). cell(2,6,0). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,0). cell(7,6,0).
cell(1,5,1). cell(2,5,2). cell(3,5,0). cell(4,5,0). cell(5,5,0). cell(6,5,0). cell(7,5,1).
cell(1,4,1). cell(2,4,2). cell(3,4,0). cell(4,4,0). cell(5,4,0). cell(6,4,1). cell(7,4,2).
cell(1,3,1). cell(2,3,2). cell(3,3,2). cell(4,3,0). cell(5,3,1). cell(6,3,1). cell(7,3,1).
cell(1,2,2). cell(2,2,1). cell(3,2,1). cell(4,2,1). cell(5,2,2). cell(6,2,2). cell(7,2,2).
cell(1,1,1). cell(2,1,2). cell(3,1,2). cell(4,1,1). cell(5,1,2). cell(6,1,1). cell(7,1,2).
control(2).
}).

% (base) ~/c4 % ilasp --version=2i c4_v677_legal_las.lp                          
% legal(V1,drop(V2)) :- control(V1); cell(V2,V3,0); not terminal.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Pre-processing                          : 0.019s
% %% Hypothesis Space Generation             : 1.053s
% %% Counterexample search                   : 0.009s
% %%   - CDOEs                               : 0s
% %%   - CDPIs                               : 0.008s
% %% Hypothesis Search                       : 0.166s
% %% Total                                   : 1.248s
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%