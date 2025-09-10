% c4_v712_line_las.lp
% TO LEARN: line/1.

% Background
board_size(7,6).
col(X) :- X = 1..M, board_size(M,N).
row(Y) :- Y = 1..N, board_size(M,N).
role(1). role(2).

% Mode bias
#modeh(line(var(r))).
#modeb(1, role(var(r))).
#modeb(1, horz(var(x),var(y),var(r))).
#modeb(1, vert(var(x),var(y),var(r))).
#modeb(1, dia1(var(x),var(y),var(r))).
#modeb(1, dia2(var(x),var(y),var(r))).
#modeb(1, terminal).
#maxv(3).

% Examples
#pos({line(2)},{line(1)},{horz(2,4,2).}).
#pos({line(1)},{line(2)},{vert(3,1,1).}).
#pos({line(2)},{ },{dia1(1,3,2).}).
#pos({line(1)},{ },{dia2(1,5,1).}).

% (base) ~/c4 % ilasp --version=4 c4_v712_line_las.lp 
% line(V1) :- horz(V2,V3,V1).
% line(V1) :- vert(V2,V3,V1).
% line(V1) :- dia1(V2,V3,V1).
% line(V1) :- dia2(V2,V3,V1).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Pre-processing                          : 0.016s
% %% Hypothesis Space Generation             : 0.524s
% %% Conflict analysis                       : 0.225s
% %%   - Positive Examples                   : 0.225s
% %% Counterexample search                   : 0.006s
% %%   - CDOEs                               : 0s
% %%   - CDPIs                               : 0.006s
% %% Hypothesis Search                       : 0.043s
% %% Total                                   : 0.816s
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%