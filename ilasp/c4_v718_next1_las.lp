% c4_v718_next1_las.lp
% TO LEARN: next/1.

% Background
board_size(7,6).
role(1). role(2).
opponent(V1,V2) :- role(V1); role(V2); V2 != V1. 

% Mode bias
#modeh(control(var(r))).
#modeh(next(control(var(r)))).
#modeb(1, role(var(r))).
#modeb(2, control(var(r))).
#modeb(1, opponent(var(r),var(r))).
#modeb(1, next(control(var(r)))).
#maxv(3).

% Examples
#pos({next(control(1))},{next(control(2)), next(control(0))},{control(2).}).
#pos({next(control(2))},{next(control(1)), next(control(0))},{control(1).}).
#neg({next(control(1)),next(control(2))},{},{}).

% (base) ~/c4 % ilasp --version=2i c4_v718_next1_las.lp   
% next(control(V1)) :- opponent(V2,V1); not next(control(V2)).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Pre-processing                          : 0.033s
% %% Hypothesis Space Generation             : 0.095s
% %% Conflict analysis                       : 0.035s
% %%   - Negative Examples                   : 0.035s
% %% Counterexample search                   : 0.003s
% %%   - CDOEs                               : 0s
% %%   - CDPIs                               : 0s
% %% Hypothesis Search                       : 0.174s
% %% Total                                   : 0.341s
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%