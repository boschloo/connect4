% c4_v707f_legal_las.lp

% TO LEARN: 
% legal(P, drop(X)) :- control(P), open(X), not terminal.

% Background knowledge -------------------------------------------------------
board_size(7,6).
col(X) :- X = 1..M, board_size(M,N).
row(Y) :- Y = 1..N, board_size(M,N).

role(1). role(2).

open(V1) :- cell(V1,V2,0).
open :- cell(V1,V2,0).

terminal :- line(V1).
terminal :- not open.

target(V1,V2) :- cell(V1,V2,0); not cell(V1,V2-1,0).
target(V1,V2,V3) :- target(V1,V2); control(V3).

horz(X,Y,P) :- cell(X,Y,P),cell(X+1,Y,P),cell(X+2,Y,P),cell(X+3,Y,P),role(P).
vert(X,Y,P) :- cell(X,Y,P),cell(X,Y+1,P),cell(X,Y+2,P),cell(X,Y+3,P),role(P).
dia1(X,Y,P) :- cell(X,Y,P),cell(X+1,Y+1,P),cell(X+2,Y+2,P),cell(X+3,Y+3,P),role(P).
dia2(X,Y,P) :- cell(X,Y,P),cell(X+1,Y-1,P),cell(X+2,Y-2,P),cell(X+3,Y-3,P),role(P).

line(P) :- horz(X,Y,P). 
line(P) :- vert(X,Y,P). 
line(P) :- dia1(X,Y,P). 
line(P) :- dia2(X,Y,P).

% Mode bias -------------------------------------------------------------------
#modeh(legal(var(r), drop(var(x)))).
#modeb(1, role(var(r))).
#modeb(1, control(var(r))).
#modeb(1, target(var(x),var(y))).
#modeb(2, cell(var(x),var(y),var(r))).
#modeb(1, line(var(r))).
#modeb(1, open(var(x))).
#modeb(1, open).
#modeb(1, terminal).
#maxv(3).

% Examples ---------------------------------------------------------------------
#pos({
legal(2,drop(1)),legal(2,drop(2)),legal(2,drop(3)),legal(2,drop(4)),legal(2,drop(5)),legal(2,drop(7))  
},{
legal(1,drop(1)),legal(1,drop(2)),legal(1,drop(3)),legal(1,drop(4)),legal(1,drop(5)),legal(1,drop(6)),
legal(1,drop(7)),legal(2,drop(6)),terminal},{
cell(1,6,0). cell(2,6,0). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,2). cell(7,6,0).
cell(1,5,0). cell(2,5,0). cell(3,5,0). cell(4,5,2). cell(5,5,0). cell(6,5,1). cell(7,5,0).
cell(1,4,0). cell(2,4,0). cell(3,4,0). cell(4,4,1). cell(5,4,0). cell(6,4,2). cell(7,4,1).
cell(1,3,0). cell(2,3,0). cell(3,3,2). cell(4,3,2). cell(5,3,0). cell(6,3,2). cell(7,3,2).
cell(1,2,0). cell(2,2,1). cell(3,2,1). cell(4,2,1). cell(5,2,0). cell(6,2,1). cell(7,2,1).
cell(1,1,1). cell(2,1,2). cell(3,1,2). cell(4,1,1). cell(5,1,0). cell(6,1,2). cell(7,1,1).
control(2).
 }).

#neg({
legal(2,drop(3))
},{},{
% Board with vertical line vert(4,1,1) 
cell(1,6,0). cell(2,6,0). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,0). cell(7,6,0).
cell(1,5,0). cell(2,5,0). cell(3,5,0). cell(4,5,0). cell(5,5,2). cell(6,5,0). cell(7,5,0).
cell(1,4,0). cell(2,4,2). cell(3,4,0). cell(4,4,1). cell(5,4,1). cell(6,4,0). cell(7,4,0).
cell(1,3,0). cell(2,3,1). cell(3,3,2). cell(4,3,1). cell(5,3,1). cell(6,3,0). cell(7,3,2).
cell(1,2,0). cell(2,2,1). cell(3,2,2). cell(4,2,1). cell(5,2,2). cell(6,2,2). cell(7,2,1).
cell(1,1,0). cell(2,1,1). cell(3,1,2). cell(4,1,1). cell(5,1,1). cell(6,1,2). cell(7,1,2).
control(2). 
}).

#neg({legal(1,drop(5))},{},{
% Board seven columns filled completely without a winner, end of the game
cell(1,6,1). cell(2,6,1). cell(3,6,1). cell(4,6,2). cell(5,6,1). cell(6,6,1). cell(7,6,1).
cell(1,5,2). cell(2,5,2). cell(3,5,2). cell(4,5,1). cell(5,5,2). cell(6,5,2). cell(7,5,2).
cell(1,4,1). cell(2,4,1). cell(3,4,1). cell(4,4,2). cell(5,4,1). cell(6,4,1). cell(7,4,1).
cell(1,3,2). cell(2,3,2). cell(3,3,2). cell(4,3,1). cell(5,3,2). cell(6,3,2). cell(7,3,2).
cell(1,2,1). cell(2,2,1). cell(3,2,1). cell(4,2,2). cell(5,2,1). cell(6,2,1). cell(7,2,1).
cell(1,1,2). cell(2,1,2). cell(3,1,2). cell(4,1,1). cell(5,1,2). cell(6,1,2). cell(7,1,2).
control(1).
}).

% (base) ~/c4 % ilasp --version=4 c4_v707f_legal_las.lp
% legal(V1,drop(V2)) :- control(V1); open(V2); not terminal.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Pre-processing                          : 0.023s
% %% Hypothesis Space Generation             : 0.269s
% %% Conflict analysis                       : 0.066s
% %%   - Negative Examples                   : 0.016s
% %%   - Positive Examples                   : 0.05s
% %% Counterexample search                   : 0.009s
% %%   - CDOEs                               : 0s
% %%   - CDPIs                               : 0.009s
% %% Hypothesis Search                       : 0.026s
% %% Total                                   : 0.398s
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%