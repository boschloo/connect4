% c4_v708a_opponent_las.lp
% TO LEARN: pponent/2.

% Background
role(1). role(2).

% Mode bias
#modeh(opponent(var(r),var(r))).
#modeb(2, role(var(r))).
#modeb(1, var(r) != var(r)).
#modeb(1, var(r) < var(r)).
#maxv(2).

% Example
#pos({opponent(1,2), opponent(2,1)},{opponent(1,1)},{}).

% (base) ~/c4 % ilasp --version=2i c4_v708a_opponent_las.lp          
% opponent(V1,V2) :- role(V1); role(V2); V1 < V2.
% opponent(V1,V2) :- role(V1); role(V2); V2 < V1.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Pre-processing                          : 0.035s
% %% Hypothesis Space Generation             : 0.01s
% %% Counterexample search                   : 0s
% %%   - CDOEs                               : 0s
% %%   - CDPIs                               : 0s
% %% Hypothesis Search                       : 0.002s
% %% Total                                   : 0.047s
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%