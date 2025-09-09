% c4_v713a_las.lp
% Learning goal/2.
% ASP-code for playing Connect Four.
% Version to be used in the learning process

% Background knowledge -------------------------------------------------------
board_size(7,6).
col(X) :- X = 1..M, board_size(M,N).
row(Y) :- Y = 1..N, board_size(M,N).

% Roles / players -------------------------------------------------------------
role(1). role(2).

% Additional concepts --------------------------------------------------------
open(V1) :- cell(V1,V2-1,0).
open :- cell(V1,V2,0).
opponent(V1,V2) :- role(V1); role(V2); V2 != V1.

% Game state update  ---------------------------------------------------------- 
target(V1,V2) :- cell(V1,V2,0); not cell(V1,V2-1,0).
next(V1,V2,V3) :- target(V1,V2); does(V3,drop(V1)).
next(V1,V2,V3) :- cell(V1,V2,V3); not target(V1,V2).
next(V1,V2,V3) :- control(V4); cell(V1,V2,V3); not does(V4,drop(V1)).

% Legal moves: Actions --------------------------------------------------------
legal(V1,drop(V2)) :- control(V1); target(V2,V3).

% Goal ---- TO BE LEARNED  ----------------------------------------------------
% goal(P,100) :- line(P).
% goal(P, 50) :- not goal(P,100), not goal(P,0), role(P).
% goal(P,  0) :- goal(P2,100), P!=P2, role(P).

#modeh(goal(var(r),100)).
#modeh(goal(var(r),50)).
#modeh(goal(var(r),0)).

#modeb(1, role(var(r))).
#modeb(1, line(var(r))).
#modeb(1, terminal).
#modeb(1, opponent(var(r),var(r))).
maxv(2).

#pos({goal(2,100), goal(1,0)},{goal(1,50), goal(1,100), goal(2,0), goal(2,50)}, {line(2). terminal.}).

#pos({goal(1,100), goal(2,0)},{goal(1,0), goal(1,50), goal(2,50), goal(2,100)}, {line(1). terminal.}).

#pos({goal(1,50), goal(2,50)},{goal(1,0), goal(1,100), goal(2,0), goal(2,100)}, { }).

% (base) ~/c4 % ilasp --version=2i c4_v713a_goal_las.lp
% goal(V1,100) :- line(V1).
% goal(V1,50) :- opponent(V1,V2); not terminal.
% goal(V1,0) :- line(V2); opponent(V1,V2).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Pre-processing                          : 0.024s
% %% Hypothesis Space Generation             : 0.08s
% %% Counterexample search                   : 0.003s
% %%   - CDOEs                               : 0s
% %%   - CDPIs                               : 0.003s
% %% Hypothesis Search                       : 0.092s
% %% Total                                   : 0.202s
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
