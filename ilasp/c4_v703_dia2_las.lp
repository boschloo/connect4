role(1). role(2).

#modeh(dia2(var(x),var(y),var(r))).
#modeh(line(var(r))).
#modeb(1, role(var(r))).
#modeb(1, cell(var(x),var(y),var(r)),(positive)).
#modeb(3, cell(var(x)+const(c),var(y)-const(c),var(r)),(positive)).
#modeb(1, dia2(var(x),var(y),var(r))).

#constant(c,1).
#constant(c,2).
#constant(c,3).

#maxv(3). 

#pos({dia2(3,5,2), line(2)},{
dia2(1,6,0), dia2(2,6,0), dia2(3,6,0), dia2(4,6,0), dia2(5,6,0), dia2(6,6,0), dia2(7,6,0), 
dia2(1,5,0), dia2(2,5,0), dia2(3,5,0), dia2(4,5,0), dia2(5,5,0), dia2(6,5,0), dia2(7,5,0), 
dia2(1,4,0), dia2(2,4,0), dia2(3,4,0), dia2(4,4,0), dia2(5,4,0), dia2(6,4,0), dia2(7,4,0), 
dia2(1,3,0), dia2(2,3,0), dia2(3,3,0), dia2(4,3,0), dia2(5,3,0), dia2(6,3,0), dia2(7,3,0), 
dia2(1,2,0), dia2(2,2,0), dia2(3,2,0), dia2(4,2,0), dia2(5,2,0), dia2(6,2,0), dia2(7,2,0), 
dia2(1,1,0), dia2(2,1,0), dia2(3,1,0), dia2(4,1,0), dia2(5,1,0), dia2(6,1,0), dia2(7,1,0), 

dia2(1,6,1), dia2(2,6,1), dia2(3,6,1), dia2(4,6,1), dia2(5,6,1), dia2(6,6,1), dia2(7,6,1), 
dia2(1,5,1), dia2(2,5,1), dia2(3,5,1), dia2(4,5,1), dia2(5,5,1), dia2(6,5,1), dia2(7,5,1), 
dia2(1,4,1), dia2(2,4,1), dia2(3,4,1), dia2(4,4,1), dia2(5,4,1), dia2(6,4,1), dia2(7,4,1), 
dia2(1,3,1), dia2(2,3,1), dia2(3,3,1), dia2(4,3,1), dia2(5,3,1), dia2(6,3,1), dia2(7,3,1), 
dia2(1,2,1), dia2(2,2,1), dia2(3,2,1), dia2(4,2,1), dia2(5,2,1), dia2(6,2,1), dia2(7,2,1), 
dia2(1,1,1), dia2(2,1,1), dia2(3,1,1), dia2(4,1,1), dia2(5,1,1), dia2(6,1,1), dia2(7,1,1), 

dia2(1,6,2), dia2(2,6,2), dia2(3,6,2), dia2(4,6,2), dia2(5,6,2), dia2(6,6,2), dia2(7,6,2), 
dia2(1,5,2), dia2(2,5,2),              dia2(4,5,2), dia2(5,5,2), dia2(6,5,2), dia2(7,5,2), 
dia2(1,4,2), dia2(2,4,2), dia2(3,4,2), dia2(4,4,2), dia2(5,4,2), dia2(6,4,2), dia2(7,4,2), 
dia2(1,3,2), dia2(2,3,2), dia2(3,3,2), dia2(4,3,2), dia2(5,3,2), dia2(6,3,2), dia2(7,3,2), 
dia2(1,2,2), dia2(2,2,2), dia2(3,2,2), dia2(4,2,2), dia2(5,2,2), dia2(6,2,2), dia2(7,2,2), 
dia2(1,1,2), dia2(2,1,2), dia2(3,1,2), dia2(4,1,2), dia2(5,1,2), dia2(6,1,2), dia2(7,1,2),
line(1)
},{
cell(1,6,0). cell(2,6,0). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,0). cell(7,6,0).
cell(1,5,0). cell(2,5,0). cell(3,5,2). cell(4,5,2). cell(5,5,0). cell(6,5,0). cell(7,5,0).
cell(1,4,0). cell(2,4,0). cell(3,4,1). cell(4,4,2). cell(5,4,0). cell(6,4,0). cell(7,4,0).
cell(1,3,0). cell(2,3,2). cell(3,3,2). cell(4,3,1). cell(5,3,2). cell(6,3,1). cell(7,3,0).
cell(1,2,1). cell(2,2,1). cell(3,2,2). cell(4,2,1). cell(5,2,1). cell(6,2,2). cell(7,2,0).
cell(1,1,2). cell(2,1,1). cell(3,1,1). cell(4,1,1). cell(5,1,2). cell(6,1,2). cell(7,1,1).
}).

% . . . . . . .
% . . 2 2 . . .
% . . 1 2 . . .
% . 2 2 1 2 1 .
% 1 1 2 1 1 2 .
% 2 1 1 1 2 2 1

#pos({dia2(3,4,1), line(1)},{
dia2(1,6,0), dia2(2,6,0), dia2(3,6,0), dia2(4,6,0), dia2(5,6,0), dia2(6,6,0), dia2(7,6,0), 
dia2(1,5,0), dia2(2,5,0), dia2(3,5,0), dia2(4,5,0), dia2(5,5,0), dia2(6,5,0), dia2(7,5,0), 
dia2(1,4,0), dia2(2,4,0), dia2(3,4,0), dia2(4,4,0), dia2(5,4,0), dia2(6,4,0), dia2(7,4,0), 
dia2(1,3,0), dia2(2,3,0), dia2(3,3,0), dia2(4,3,0), dia2(5,3,0), dia2(6,3,0), dia2(7,3,0), 
dia2(1,2,0), dia2(2,2,0), dia2(3,2,0), dia2(4,2,0), dia2(5,2,0), dia2(6,2,0), dia2(7,2,0), 
dia2(1,1,0), dia2(2,1,0), dia2(3,1,0), dia2(4,1,0), dia2(5,1,0), dia2(6,1,0), dia2(7,1,0), 

dia2(1,6,1), dia2(2,6,1), dia2(3,6,1), dia2(4,6,1), dia2(5,6,1), dia2(6,6,1), dia2(7,6,1), 
dia2(1,5,1), dia2(2,5,1), dia2(3,5,1), dia2(4,5,1), dia2(5,5,1), dia2(6,5,1), dia2(7,5,1), 
dia2(1,4,1), dia2(2,4,1),              dia2(4,4,1), dia2(5,4,1), dia2(6,4,1), dia2(7,4,1), 
dia2(1,3,1), dia2(2,3,1), dia2(3,3,1), dia2(4,3,1), dia2(5,3,1), dia2(6,3,1), dia2(7,3,1), 
dia2(1,2,1), dia2(2,2,1), dia2(3,2,1), dia2(4,2,1), dia2(5,2,1), dia2(6,2,1), dia2(7,2,1), 
dia2(1,1,1), dia2(2,1,1), dia2(3,1,1), dia2(4,1,1), dia2(5,1,1), dia2(6,1,1), dia2(7,1,1), 

dia2(1,6,2), dia2(2,6,2), dia2(3,6,2), dia2(4,6,2), dia2(5,6,2), dia2(6,6,2), dia2(7,6,2), 
dia2(1,5,2), dia2(2,5,2), dia2(3,5,2), dia2(4,5,2), dia2(5,5,2), dia2(6,5,2), dia2(7,5,2), 
dia2(1,4,2), dia2(2,4,2), dia2(3,4,2), dia2(4,4,2), dia2(5,4,2), dia2(6,4,2), dia2(7,4,2), 
dia2(1,3,2), dia2(2,3,2), dia2(3,3,2), dia2(4,3,2), dia2(5,3,2), dia2(6,3,2), dia2(7,3,2), 
dia2(1,2,2), dia2(2,2,2), dia2(3,2,2), dia2(4,2,2), dia2(5,2,2), dia2(6,2,2), dia2(7,2,2), 
dia2(1,1,2), dia2(2,1,2), dia2(3,1,2), dia2(4,1,2), dia2(5,1,2), dia2(6,1,2), dia2(7,1,2),
line(2)
},{
cell(1,6,0). cell(2,6,0). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,0). cell(7,6,0).
cell(1,5,0). cell(2,5,0). cell(3,5,0). cell(4,5,0). cell(5,5,0). cell(6,5,0). cell(7,5,0).
cell(1,4,0). cell(2,4,2). cell(3,4,1). cell(4,4,2). cell(5,4,0). cell(6,4,0). cell(7,4,0).
cell(1,3,0). cell(2,3,1). cell(3,3,2). cell(4,3,1). cell(5,3,0). cell(6,3,0). cell(7,3,0).
cell(1,2,2). cell(2,2,1). cell(3,2,2). cell(4,2,1). cell(5,2,1). cell(6,2,0). cell(7,2,0).
cell(1,1,2). cell(2,1,1). cell(3,1,2). cell(4,1,1). cell(5,1,2). cell(6,1,1). cell(7,1,0).
}).

% . . . . . . .
% . . . . . . .
% . 2 1 2 . . .
% . 1 2 1 . . .
% 2 1 2 1 1 . .
% 2 1 2 1 2 1 .

#pos({dia2(2,4,1), line(1)},{
dia2(1,6,0), dia2(2,6,0), dia2(3,6,0), dia2(4,6,0), dia2(5,6,0), dia2(6,6,0), dia2(7,6,0), 
dia2(1,5,0), dia2(2,5,0), dia2(3,5,0), dia2(4,5,0), dia2(5,5,0), dia2(6,5,0), dia2(7,5,0), 
dia2(1,4,0), dia2(2,4,0), dia2(3,4,0), dia2(4,4,0), dia2(5,4,0), dia2(6,4,0), dia2(7,4,0), 
dia2(1,3,0), dia2(2,3,0), dia2(3,3,0), dia2(4,3,0), dia2(5,3,0), dia2(6,3,0), dia2(7,3,0), 
dia2(1,2,0), dia2(2,2,0), dia2(3,2,0), dia2(4,2,0), dia2(5,2,0), dia2(6,2,0), dia2(7,2,0), 
dia2(1,1,0), dia2(2,1,0), dia2(3,1,0), dia2(4,1,0), dia2(5,1,0), dia2(6,1,0), dia2(7,1,0), 

dia2(1,6,1), dia2(2,6,1), dia2(3,6,1), dia2(4,6,1), dia2(5,6,1), dia2(6,6,1), dia2(7,6,1), 
dia2(1,5,1), dia2(2,5,1), dia2(3,5,1), dia2(4,5,1), dia2(5,5,1), dia2(6,5,1), dia2(7,5,1), 
dia2(1,4,1),              dia2(3,4,1), dia2(4,4,1), dia2(5,4,1), dia2(6,4,1), dia2(7,4,1), 
dia2(1,3,1), dia2(2,3,1), dia2(3,3,1), dia2(4,3,1), dia2(5,3,1), dia2(6,3,1), dia2(7,3,1), 
dia2(1,2,1), dia2(2,2,1), dia2(3,2,1), dia2(4,2,1), dia2(5,2,1), dia2(6,2,1), dia2(7,2,1), 
dia2(1,1,1), dia2(2,1,1), dia2(3,1,1), dia2(4,1,1), dia2(5,1,1), dia2(6,1,1), dia2(7,1,1), 

dia2(1,6,2), dia2(2,6,2), dia2(3,6,2), dia2(4,6,2), dia2(5,6,2), dia2(6,6,2), dia2(7,6,2), 
dia2(1,5,2), dia2(2,5,2), dia2(3,5,2), dia2(4,5,2), dia2(5,5,2), dia2(6,5,2), dia2(7,5,2), 
dia2(1,4,2), dia2(2,4,2), dia2(3,4,2), dia2(4,4,2), dia2(5,4,2), dia2(6,4,2), dia2(7,4,2), 
dia2(1,3,2), dia2(2,3,2), dia2(3,3,2), dia2(4,3,2), dia2(5,3,2), dia2(6,3,2), dia2(7,3,2), 
dia2(1,2,2), dia2(2,2,2), dia2(3,2,2), dia2(4,2,2), dia2(5,2,2), dia2(6,2,2), dia2(7,2,2), 
dia2(1,1,2), dia2(2,1,2), dia2(3,1,2), dia2(4,1,2), dia2(5,1,2), dia2(6,1,2), dia2(7,1,2),
line(2)
},{
cell(1,6,0). cell(2,6,0). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,0). cell(7,6,0).
cell(1,5,0). cell(2,5,0). cell(3,5,0). cell(4,5,0). cell(5,5,0). cell(6,5,0). cell(7,5,0).
cell(1,4,1). cell(2,4,1). cell(3,4,0). cell(4,4,0). cell(5,4,0). cell(6,4,0). cell(7,4,0).
cell(1,3,2). cell(2,3,2). cell(3,3,1). cell(4,3,0). cell(5,3,0). cell(6,3,0). cell(7,3,0).
cell(1,2,1). cell(2,2,2). cell(3,2,1). cell(4,2,1). cell(5,2,0). cell(6,2,0). cell(7,2,0).
cell(1,1,2). cell(2,1,2). cell(3,1,2). cell(4,1,1). cell(5,1,1). cell(6,1,2). cell(7,1,0).
}).

% . . . . . . .
% . . . . . . .
% 1 1 . . . . .
% 2 2 1 . . . .
% 1 2 1 1 . . .
% 2 2 2 1 1 2 .

% (base) ~/c4 % ilasp --version=2i c4_v703_dia2_las.lp -ml=5 --max-rule-length=6
% line(V1) :- dia2(V2,V3,V1).
% dia2(V1,V2,V3) :- role(V3); cell(V1,V2,V3); cell(V1+1,V2-1,V3); cell(V1+2,V2-2,V3); cell(V1+3,V2-3,V3).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Pre-processing                          : 0.024s
% %% Hypothesis Space Generation             : 13.15s
% %% Counterexample search                   : 0.014s
% %%   - CDOEs                               : 0s
% %%   - CDPIs                               : 0.012s
% %% Hypothesis Search                       : 3.757s
% %% Total                                   : 16.962s
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%