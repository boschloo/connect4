% c4_v713_las.lp
% TO LEARN: goal/2.

% Background 
role(1). role(2).
opponent(V1,V2) :- role(V1); role(V2); V2 != V1.

% Mode bias
#modeh(goal(var(r),100)).
#modeh(goal(var(r),50)).
#modeh(goal(var(r),0)).

#modeb(1, role(var(r))).
#modeb(1, line(var(r))).
#modeb(1, terminal).
#modeb(1, opponent(var(r),var(r))).
maxv(2).

% Examples
#pos({goal(2,100), goal(1,0)},{goal(1,50), goal(1,100), goal(2,0), goal(2,50)}, {line(2). terminal.}).
#pos({goal(1,100), goal(2,0)},{goal(1,0), goal(1,50), goal(2,50), goal(2,100)}, {line(1). terminal.}).
#pos({goal(1,50), goal(2,50)},{goal(1,0), goal(1,100), goal(2,0), goal(2,100)}, { }).

% (base) ~/c4 % ilasp --version=2i c4_v713_goal_las.lp 
% goal(V1,100) :- line(V1).
% goal(V1,50) :- opponent(V1,V2); not terminal.
% goal(V1,0) :- line(V2); opponent(V1,V2).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Pre-processing                          : 0.024s
% %% Hypothesis Space Generation             : 0.08s
% %% Counterexample search                   : 0.003s
% %%   - CDOEs                               : 0s
% %%   - CDPIs                               : 0.003s
% %% Hypothesis Search                       : 0.091s
% %% Total                                   : 0.201s
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
