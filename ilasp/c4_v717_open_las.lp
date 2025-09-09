% c4_v717_open_las.lp
% TO LEARN: open, open/1

% Background
board_size(7,6).
col(X) :- X = 1..M, board_size(M,N).
row(Y) :- Y = 1..N, board_size(M,N).

role(1). role(2).

% Mode bias 
#modeh(open).
#modeh(open(var(x))).
#modeb(1,role(var(r))).
#modeb(2, cell(var(x),var(y),var(r))).
#modeb(2, cell(var(x),var(y),0)). 
#maxv(3).

% Examples 
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

% (base) ~/c4 % ilasp --version=2i c4_v717a_open_las.lp 
% open :- cell(V1,V2,0).
% open(V1) :- cell(V1,V2,0).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Pre-processing                          : 0.024s
% %% Hypothesis Space Generation             : 0.088s
% %% Counterexample search                   : 0.006s
% %%   - CDOEs                               : 0s
% %%   - CDPIs                               : 0.003s
% %% Hypothesis Search                       : 0.017s
% %% Total                                   : 0.134s
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
