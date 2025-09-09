% c4_v715_terminal_las.lp
% TO LEARN: terminal/0.

% Background
board_size(7,6).
col(X) :- X = 1..M, board_size(M,N).
row(Y) :- Y = 1..N, board_size(M,N).

role(1). role(2).
open(V1) :- cell(V1,V2-1,0).
open :- cell(V1,V2,0).

horz(V1,V2,V3) :- role(V3); cell(V1,V2,V3); cell(V1+1,V2,V3); cell(V1+2,V2,V3); cell(V1+3,V2,V3).
vert(V1,V2,V3) :- role(V3); cell(V1,V2,V3); cell(V1,V2+1,V3); cell(V1,V2+2,V3); cell(V1,V2+3,V3).
dia1(V1,V2,V3) :- role(V3); cell(V1,V2,V3); cell(V1+1,V2+1,V3); cell(V1+2,V2+2,V3); cell(V1+3,V2+3,V3).
dia2(V1,V2,V3) :- role(V3); cell(V1,V2,V3); cell(V1+1,V2-1,V3); cell(V1+2,V2-2,V3); cell(V1+3,V2-3,V3).

line(P) :- horz(X,Y,P). 
line(P) :- vert(X,Y,P). 
line(P) :- dia1(X,Y,P). 
line(P) :- dia2(X,Y,P).

% Mode bias
#modeh(terminal).
#modeb(2, role(var(r))).
#modeb(1, line(var(r))).
#modeb(1, open).
#modeb(1, open(var(x))).
maxv(2).

% Examples
#pos({ },{terminal},{
cell(1,6,0). cell(2,6,0). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,0). cell(7,6,0).
cell(1,5,0). cell(2,5,0). cell(3,5,0). cell(4,5,0). cell(5,5,0). cell(6,5,0). cell(7,5,0).
cell(1,4,0). cell(2,4,0). cell(3,4,0). cell(4,4,0). cell(5,4,0). cell(6,4,0). cell(7,4,0).
cell(1,3,0). cell(2,3,0). cell(3,3,0). cell(4,3,0). cell(5,3,0). cell(6,3,0). cell(7,3,0).
cell(1,2,0). cell(2,2,0). cell(3,2,0). cell(4,2,0). cell(5,2,0). cell(6,2,0). cell(7,2,0).
cell(1,1,0). cell(2,1,0). cell(3,1,0). cell(4,1,0). cell(5,1,0). cell(6,1,0). cell(7,1,0).
}).

% . . . . . . .
% . . . . . . .
% . . . . . . .
% . . . . . . .
% . . . . . . .
% . . . . . . .

#pos({terminal},{},{
cell(1,6,1). cell(2,6,1). cell(3,6,1). cell(4,6,2). cell(5,6,1). cell(6,6,1). cell(7,6,1).
cell(1,5,2). cell(2,5,2). cell(3,5,2). cell(4,5,1). cell(5,5,2). cell(6,5,2). cell(7,5,2).
cell(1,4,1). cell(2,4,1). cell(3,4,1). cell(4,4,2). cell(5,4,1). cell(6,4,1). cell(7,4,1).
cell(1,3,2). cell(2,3,2). cell(3,3,2). cell(4,3,1). cell(5,3,2). cell(6,3,2). cell(7,3,2).
cell(1,2,1). cell(2,2,1). cell(3,2,1). cell(4,2,2). cell(5,2,1). cell(6,2,1). cell(7,2,1).
cell(1,1,2). cell(2,1,2). cell(3,1,2). cell(4,1,1). cell(5,1,2). cell(6,1,2). cell(7,1,2).
}).

% 1 1 1 2 1 1 1
% 2 2 2 1 2 2 2
% 1 1 1 2 1 1 1
% 2 2 2 1 2 2 2
% 1 1 1 2 1 1 1
% 2 2 2 1 2 2 2

#pos({},{terminal},{
cell(1,6,0). cell(2,6,1). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,0). cell(7,6,0).
cell(1,5,0). cell(2,5,2). cell(3,5,0). cell(4,5,0). cell(5,5,1). cell(6,5,0). cell(7,5,0).
cell(1,4,0). cell(2,4,1). cell(3,4,0). cell(4,4,1). cell(5,4,2). cell(6,4,0). cell(7,4,2).
cell(1,3,0). cell(2,3,2). cell(3,3,2). cell(4,3,2). cell(5,3,1). cell(6,3,0). cell(7,3,2).
cell(1,2,0). cell(2,2,2). cell(3,2,2). cell(4,2,2). cell(5,2,1). cell(6,2,1). cell(7,2,1).
cell(1,1,1). cell(2,1,1). cell(3,1,1). cell(4,1,2). cell(5,1,1). cell(6,1,1). cell(7,1,2).
}).

% . 1 . . . . .
% . 2 . . 1 . .
% . 1 . 1 2 . 2
% . 2 2 2 1 . 2
% . 2 2 2 1 1 1
% 1 1 1 2 1 1 2

#pos({terminal},{},{
cell(1,6,0). cell(2,6,1). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,0). cell(7,6,0).
cell(1,5,0). cell(2,5,2). cell(3,5,0). cell(4,5,0). cell(5,5,1). cell(6,5,0). cell(7,5,0).
cell(1,4,0). cell(2,4,1). cell(3,4,0). cell(4,4,1). cell(5,4,2). cell(6,4,0). cell(7,4,2).
cell(1,3,0). cell(2,3,2). cell(3,3,2). cell(4,3,2). cell(5,3,1). cell(6,3,0). cell(7,3,2).
cell(1,2,2). cell(2,2,2). cell(3,2,2). cell(4,2,2). cell(5,2,1). cell(6,2,1). cell(7,2,1).
cell(1,1,1). cell(2,1,1). cell(3,1,1). cell(4,1,2). cell(5,1,1). cell(6,1,1). cell(7,1,2).
}).

% . 1 . . . . .
% . 2 . . 1 . .
% . 1 . 1 2 . 2
% . 2 2 2 1 . 2
% 2 2 2 2 1 1 1
% 1 1 1 2 1 1 2

% (base) ~/c4 % ilasp --version=2i c4_v715_terminal_las.lp
% terminal :- line(V1).
% terminal :- not open.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Pre-processing                          : 0.025s
% %% Hypothesis Space Generation             : 0.014s
% %% Counterexample search                   : 0.018s
% %%   - CDOEs                               : 0s
% %%   - CDPIs                               : 0.017s
% %% Hypothesis Search                       : 0.021s
% %% Total                                   : 0.078s
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%