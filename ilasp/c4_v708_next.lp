% c4_v641_las.lp
% Learning next/3.
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
does(2,drop(1)).

% (base) ~/c4 % ilasp --version=2i c4_v708_next_las.lp -ml=4 --max-rule-length=5
% next(V1,V2,0) :- cell(V1,V2-1,0).
% next(V1,V2,V3) :- role(V3); cell(V1,V2,V3).
% next(V1,V2,V3) :- control(V4); cell(V1,V2,V3); not does(V4,drop(V1)).
% next(V1,V2,V3) :- cell(V4,V2,V3); does(V3,drop(V1)); not cell(V1,V2-1,0). GAAT NIET GOED bij drop(1)

#show next/3.

