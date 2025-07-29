% c4_v716_target3_las.lp
% Learning the targets
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

% Additional concepts --------------------------------------------------------
open :- cell(V1,V2,V3); not role(V3).
open(V1) :- cell(V1,V2,V3); not role(V3).

% Game state update  ---- TO BE LEARNED ---------------------------------------- 
% target(X,Y,P) :- does(P, drop(X)), cell(X,Y,0), not cell(X,Y-1,0).

#modeh(target(var(x),var(y),var(r))).

#modeb(1,role(var(r))).
#modeb(2, cell(var(x),var(y),var(r))).
#modeb(2, cell(var(x),var(y),0)).
#modeb(2, cell(var(x),var(y)-1,var(r))).
#modeb(2, cell(var(x),var(y)-1,0)).
#modeb(1, control(var(r))).
#modeb(1, does(var(r),drop(var(x)))).
#modeb(1, open).
#modeb(1, open(var(x))).
#maxv(3).

#pos({target(1,2,2)},{target(1,1,2), target(1,3,2), target(1,4,2), target(1,5,2), target(1,6,2), 
target(2,3,2),target(1,2,1)},{control(2). does(2,drop(1)).
}).

% (base) ~/c4 % ilasp --version=2i c4_v716_target3_las.lp
% target(V1,V2,V3) :- cell(V1,V2,0); does(V3,drop(V1)); not cell(V1,V2-1,0).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Pre-processing                          : 0.033s
% %% Hypothesis Space Generation             : 0.789s
% %% Counterexample search                   : 0.003s
% %%   - CDOEs                               : 0s
% %%   - CDPIs                               : 0.002s
% %% Hypothesis Search                       : 0.084s
% %% Total                                   : 0.911s
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%