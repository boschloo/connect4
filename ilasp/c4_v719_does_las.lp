% c4_v719_does_las.lp
% TO LEARN: does/2.

% Background
role(1). role(2).

cell(1,6,0). cell(2,6,0). cell(3,6,0). cell(4,6,2). cell(5,6,0). cell(6,6,0). cell(7,6,0).
cell(1,5,0). cell(2,5,0). cell(3,5,0). cell(4,5,2). cell(5,5,0). cell(6,5,0). cell(7,5,0).
cell(1,4,0). cell(2,4,0). cell(3,4,0). cell(4,4,1). cell(5,4,1). cell(6,4,0). cell(7,4,0).
cell(1,3,0). cell(2,3,0). cell(3,3,0). cell(4,3,2). cell(5,3,2). cell(6,3,0). cell(7,3,0).
cell(1,2,0). cell(2,2,0). cell(3,2,1). cell(4,2,1). cell(5,2,1). cell(6,2,0). cell(7,2,0).
cell(1,1,1). cell(2,1,0). cell(3,1,2). cell(4,1,1). cell(5,1,2). cell(6,1,0). cell(7,1,0).
control(2).

% . . . 2 . . .
% . . . 2 . . .
% . . . 1 1 . .
% . . . 2 2 . .
% . . 1 1 1 . .
% 1 . 2 1 2 . .

% legal(V1,drop(V2)) :- control(V1); cell(V2,V3,0); not terminal.
legal(V1,drop(V2)) :- control(V1); open(V2); not terminal.

% Row-of-four v700, v701, v702, v703-------------
horz(V1,V2,V3) :- role(V3); cell(V1,V2,V3); cell(V1+1,V2,V3); cell(V1+2,V2,V3); cell(V1+3,V2,V3).
vert(V1,V2,V3) :- role(V3); cell(V1,V2,V3); cell(V1,V2+1,V3); cell(V1,V2+2,V3); cell(V1,V2+3,V3).
dia1(V1,V2,V3) :- role(V3); cell(V1,V2,V3); cell(V1+1,V2+1,V3); cell(V1+2,V2+2,V3); cell(V1+3,V2+3,V3).
dia2(V1,V2,V3) :- role(V3); cell(V1,V2,V3); cell(V1+1,V2-1,V3); cell(V1+2,V2-2,V3); cell(V1+3,V2-3,V3).

% line v711 -------------------------------------
line(V1) :- horz(V2,V3,V1).
line(V1) :- vert(V2,V3,V1).
line(V1) :- dia1(V2,V3,V1).
line(V1) :- dia2(V2,V3,V1).

% terminal v715 ---------------------------------
terminal :- not open.
terminal :- role(V1); line(V1).

% open v717 ------------------------------------
open(V1) :- cell(V1,V2,0).
open :- cell(V1,V2,0).

% Mode bias
#modeha(does(var(x),var(a))).
#modec(legal(var(x),var(a))).
#modeb(1, control(var(x))).
#modeb(1, terminal).

% Examples
#pos({does(2,drop(1))},{does(2,drop(4))}).

% (base) ~/c4 % ilasp --version=4 c4_v719_does_las.lp
% 1 {does(V2,V1) : legal(V2,V1) } 1.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Pre-processing                          : 0.019s
% %% Hypothesis Space Generation             : 0.085s
% %% Conflict analysis                       : 1.4s
% %%   - Positive Examples                   : 1.4s
% %% Counterexample search                   : 0.002s
% %%   - CDOEs                               : 0s
% %%   - CDPIs                               : 0.002s
% %% Hypothesis Search                       : 0.047s
% %% Total                                   : 1.564s
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%