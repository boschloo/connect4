% c4_v706_targets_las.lp
% TO LEARN: target/2, target/3

% Background
role(1). role(2).

cell(1,6,0). cell(2,6,0). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,2). cell(7,6,0).
cell(1,5,0). cell(2,5,0). cell(3,5,0). cell(4,5,2). cell(5,5,0). cell(6,5,1). cell(7,5,0).
cell(1,4,0). cell(2,4,0). cell(3,4,0). cell(4,4,1). cell(5,4,0). cell(6,4,2). cell(7,4,1).
cell(1,3,0). cell(2,3,0). cell(3,3,2). cell(4,3,2). cell(5,3,0). cell(6,3,2). cell(7,3,2).
cell(1,2,0). cell(2,2,1). cell(3,2,1). cell(4,2,1). cell(5,2,0). cell(6,2,1). cell(7,2,1).
cell(1,1,1). cell(2,1,2). cell(3,1,2). cell(4,1,1). cell(5,1,0). cell(6,1,2). cell(7,1,1).

% Mode bias
#modeh(target(var(x),var(y))).
#modeh(target(var(x),var(y),var(r))).

#modeb(1,role(var(r))).
#modeb(1, target(var(x),var(y))).
#modeb(2, cell(var(x),var(y),var(r))).
#modeb(2, cell(var(x),var(y),0)).
#modeb(2, cell(var(x),var(y)-1,var(r))).
#modeb(2, cell(var(x),var(y)-1,0)).
#modeb(1, control(var(r))).
#modeb(1, does(var(r),drop(var(x)))).
#modeb(1, open).
#modeb(1, open(var(x))).
#maxv(3).

% Examples
#pos({target(7,5), target(2,3), target(1,2), target(4,6), target(3,4), target(5,1),target(7,5), 
      target(2,3,2), target(1,2,2), target(4,6,2), target(3,4,2), target(5,1,2) },{
target(1,6),  target(2,6), target(3,6),              target(5,6), target(6,6),              
target(1,5),  target(2,5), target(3,5), target(4,5), target(5,5), target(6,5),
target(1,4),  target(2,4),              target(4,4), target(5,4), target(6,4), target(7,4),
target(1,3),               target(3,3), target(4,3), target(5,3), target(6,3), target(7,3),
              target(2,2), target(3,2), target(4,2), target(5,2), target(6,2), target(7,2),
target(1,1),  target(2,1), target(3,1), target(4,1),              target(6,1), target(7,1)          
},{control(2). does(2,drop(1)).}).

% (base) ~/c4 % ilasp --version=2i c4_v706_targets_las.lp
% target(V1,V2,V3) :- target(V1,V2); control(V3).
% target(V1,V2) :- cell(V1,V2,0); not cell(V1,V2-1,0).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Pre-processing                          : 0.032s
% %% Hypothesis Space Generation             : 1.639s
% %% Counterexample search                   : 0.002s
% %%   - CDOEs                               : 0s
% %%   - CDPIs                               : 0.002s
% %% Hypothesis Search                       : 0.228s
% %% Total                                   : 1.906s
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
