% c4_v717_open_las.lp
% Learning open
% ASP-code for playing Connect Four.
% Version to be used in the learning process

% Background knowledge -------------------------------------------------------
board_size(7,6).
col(X) :- X = 1..M, board_size(M,N).
row(Y) :- Y = 1..N, board_size(M,N).

% Roles / players -------------------------------------------------------------
role(1). role(2).

% Game state ------------------------------------------------------------------
control(2).

% open(V1) :- cell(V1,V2-1,0).

#modeh(open(var(x))).
#modeh(open).
#modeb(1,role(var(r))).
#modeb(1,control(var(r))).
#modeb(2, cell(var(x),var(y),var(r))).
#modeb(2, cell(var(x),var(y),0)).
#modeb(2, cell(var(x),var(y)-1,var(r))).
#modeb(2, cell(var(x),var(y)-1,0)).

#maxv(3).

#pos({open, open(1), open(2), open(3), open(4), open(5), open(7)},{open(6)},{
cell(1,6,0). cell(2,6,0). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,2). cell(7,6,0).
cell(1,5,0). cell(2,5,0). cell(3,5,0). cell(4,5,2). cell(5,5,0). cell(6,5,1). cell(7,5,0).
cell(1,4,0). cell(2,4,0). cell(3,4,0). cell(4,4,1). cell(5,4,0). cell(6,4,2). cell(7,4,1).
cell(1,3,0). cell(2,3,0). cell(3,3,2). cell(4,3,2). cell(5,3,0). cell(6,3,2). cell(7,3,2).
cell(1,2,0). cell(2,2,1). cell(3,2,1). cell(4,2,1). cell(5,2,0). cell(6,2,1). cell(7,2,1).
cell(1,1,1). cell(2,1,2). cell(3,1,2). cell(4,1,1). cell(5,1,0). cell(6,1,2). cell(7,1,1).
}).

% . . . . . 2 .
% . . . 2 . 1 .
% . . . 1 . 2 1
% . . 2 2 . 2 2
% . 1 1 1 . 1 1
% 1 2 2 1 . 2 1

#pos({},{open, open(1), open(2), open(3), open(4), open(5), open(6), open(7)},{
cell(1,6,1). cell(2,6,1). cell(3,6,1). cell(4,6,2). cell(5,6,1). cell(6,6,1). cell(7,6,1).
cell(1,5,2). cell(2,5,2). cell(3,5,2). cell(4,5,1). cell(5,5,2). cell(6,5,2). cell(7,5,2).
cell(1,4,1). cell(2,4,1). cell(3,4,1). cell(4,4,2). cell(5,4,1). cell(6,4,1). cell(7,4,1).
cell(1,3,2). cell(2,3,2). cell(3,3,2). cell(4,3,1). cell(5,3,2). cell(6,3,2). cell(7,3,2).
cell(1,2,1). cell(2,2,1). cell(3,2,1). cell(4,2,2). cell(5,2,1). cell(6,2,1). cell(7,2,1).
cell(1,1,2). cell(2,1,2). cell(3,1,2). cell(4,1,1). cell(5,1,2). cell(6,1,2). cell(7,1,2).}).

% 1 1 1 2 1 1 1
% 2 2 2 1 2 2 2
% 1 1 1 2 1 1 1
% 2 2 2 1 2 2 2
% 1 1 1 2 1 1 1
% 2 2 2 1 2 2 2

% (base) ~/c4 % ilasp --version=2i c4_v717_open_las.lp   
% open(V1) :- cell(V1,V2-1,0).
% open :- cell(V1,V2-1,0).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Pre-processing                          : 0.036s
% %% Hypothesis Space Generation             : 0.372s
% %% Counterexample search                   : 0.007s
% %%   - CDOEs                               : 0s
% %%   - CDPIs                               : 0.005s
% %% Hypothesis Search                       : 0.07s
% %% Total                                   : 0.485s
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%