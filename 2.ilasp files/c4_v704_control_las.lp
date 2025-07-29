% c4_v704_control_las.lp
% to learn: control/1.

board_size(7,6).
role(1). role(2). 

% Predicate numberOf/2 ----------------------------
count(1,0,P,0) :- role(P).
count(X,Y,P,N) :- count(X,Y-1,P,N-1), cell(X,Y,P).
count(X,1,P,N) :- count(X-1,Y-1,P,N-1), not cell(X-1,Y,_), cell(X,1,_), cell(X,1,P).
count(X,Y,P,N) :- count(X,Y-1,P,N), cell(X,Y,_), not cell(X,Y,P).
count(X,1,P,N) :- count(X-1,Y-1,P,N), not cell(X-1,Y,_), cell(X,1,_), not cell(X,1,P).
numberOf(P,N) :- count(X,Y,P,N), board_size(X,Y).

#pos({control(1)},{control(2)},{
cell(1,6,0). cell(2,6,0). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,0). cell(7,6,0).
cell(1,5,0). cell(2,5,0). cell(3,5,0). cell(4,5,0). cell(5,5,2). cell(6,5,0). cell(7,5,0).
cell(1,4,0). cell(2,4,2). cell(3,4,0). cell(4,4,0). cell(5,4,1). cell(6,4,0). cell(7,4,0).
cell(1,3,0). cell(2,3,1). cell(3,3,2). cell(4,3,1). cell(5,3,1). cell(6,3,0). cell(7,3,2).
cell(1,2,0). cell(2,2,1). cell(3,2,2). cell(4,2,2). cell(5,2,2). cell(6,2,1). cell(7,2,1).
cell(1,1,0). cell(2,1,1). cell(3,1,2). cell(4,1,1). cell(5,1,1). cell(6,1,2). cell(7,1,2).
}).

#pos({control(2)},{control(1)},{
cell(1,6,0). cell(2,6,0). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,0). cell(7,6,0).
cell(1,5,0). cell(2,5,0). cell(3,5,0). cell(4,5,0). cell(5,5,2). cell(6,5,0). cell(7,5,0).
cell(1,4,0). cell(2,4,2). cell(3,4,0). cell(4,4,0). cell(5,4,1). cell(6,4,0). cell(7,4,0).
cell(1,3,0). cell(2,3,1). cell(3,3,2). cell(4,3,1). cell(5,3,1). cell(6,3,0). cell(7,3,2).
cell(1,2,0). cell(2,2,1). cell(3,2,2). cell(4,2,2). cell(5,2,2). cell(6,2,1). cell(7,2,1).
cell(1,1,1). cell(2,1,1). cell(3,1,2). cell(4,1,1). cell(5,1,1). cell(6,1,2). cell(7,1,2).
}).

#pos({control(1)},{control(2)},{
cell(1,6,0). cell(2,6,0). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,0). cell(7,6,0).
cell(1,5,0). cell(2,5,0). cell(3,5,0). cell(4,5,0). cell(5,5,2). cell(6,5,0). cell(7,5,0).
cell(1,4,0). cell(2,4,2). cell(3,4,0). cell(4,4,0). cell(5,4,1). cell(6,4,0). cell(7,4,0).
cell(1,3,0). cell(2,3,1). cell(3,3,2). cell(4,3,1). cell(5,3,1). cell(6,3,0). cell(7,3,2).
cell(1,2,0). cell(2,2,1). cell(3,2,2). cell(4,2,2). cell(5,2,2). cell(6,2,1). cell(7,2,1).
cell(1,1,2). cell(2,1,1). cell(3,1,2). cell(4,1,1). cell(5,1,1). cell(6,1,2). cell(7,1,2).
}).

#modeh(control(var(r))).
#modeb(2, role(var(r))).
#modeb(2, numberOf(var(r),var(n))).
#modeb(2, var(n) < var(n)).
#modeb(2, var(r) < var(r)).
#maxv(4).

% control(V1) :- numberOf(V1,V3); numberOf(V2,V3); V1 < V2.
% control(V1) :- numberOf(V1,V2); numberOf(V4,V3); V2 < V3.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Pre-processing                          : 0.037s
% %% Hypothesis Space Generation             : 0.124s
% %% Counterexample search                   : 0.026s
% %%   - CDOEs                               : 0s
% %%   - CDPIs                               : 0.026s
% %% Hypothesis Search                       : 0.009s
% %% Total                                   : 0.196s
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
