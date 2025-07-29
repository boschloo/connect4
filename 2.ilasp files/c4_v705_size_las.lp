% c4_v705_boardsize_las.lp
% Return the board size.

role(1). role(2).
col(X) :- cell(X,_,_).
row(Y) :- cell(_,Y,_).

#pos({size(7,6)},{
size(1,1), size(2,1), size(3,1), size(4,1), size(5,1), size(6,1), size(7,1), 
size(1,2), size(2,2), size(3,2), size(4,2), size(5,2), size(6,2), size(7,2), 
size(1,3), size(2,3), size(3,3), size(4,3), size(5,3), size(6,3), size(7,3), 
size(1,4), size(2,4), size(3,4), size(4,4), size(5,4), size(6,4), size(7,4), 
size(1,5), size(2,5), size(3,5), size(4,5), size(5,5), size(6,5), size(7,5), 
size(1,6), size(2,6), size(3,6), size(4,6), size(5,6), size(6,6), 
size(1,7), size(2,7), size(3,7), size(4,7), size(5,7), size(6,7), size(7,7)
},{
cell(1,6,0). cell(2,6,0). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,0). cell(7,6,0).
cell(1,5,0). cell(2,5,0). cell(3,5,0). cell(4,5,0). cell(5,5,0). cell(6,5,0). cell(7,5,0).
cell(1,4,0). cell(2,4,0). cell(3,4,0). cell(4,4,0). cell(5,4,0). cell(6,4,0). cell(7,4,0).
cell(1,3,0). cell(2,3,0). cell(3,3,0). cell(4,3,0). cell(5,3,0). cell(6,3,0). cell(7,3,0).
cell(1,2,0). cell(2,2,0). cell(3,2,0). cell(4,2,0). cell(5,2,0). cell(6,2,0). cell(7,2,0).
cell(1,1,1). cell(2,1,0). cell(3,1,0). cell(4,1,0). cell(5,1,0). cell(6,1,0). cell(7,1,0).
}).

#modeh(size(var(x), var(y))).
#modeh(greaterX(var(x))).
#modeh(greaterY(var(y))).
#modeb(1, role(var(r))).
#modeb(1, greaterX(var(x))).
#modeb(1, greaterY(var(y))).
#modeb(2, col(var(x))).
#modeb(2, row(var(y))).
#modeb(1, var(x) > var(x)).
#modeb(1, var(y) > var(y)).
#maxv(2).

% (base) ~/c4 % ilasp --version=2i c4_v705_size_las.lp -ml=5 --max-rule-length=6
% greaterY(V1) :- row(V1); row(V2); V2 > V1.
% greaterX(V1) :- col(V1); col(V2); V2 > V1.
% size(V1,V2) :- col(V1); row(V2); not greaterX(V1); not greaterY(V2).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Pre-processing                          : 0.024s
% %% Hypothesis Space Generation             : 0.023s
% %% Counterexample search                   : 0.003s
% %%   - CDOEs                               : 0s
% %%   - CDPIs                               : 0.002s
% %% Hypothesis Search                       : 0.015s
% %% Total                                   : 0.066s
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
