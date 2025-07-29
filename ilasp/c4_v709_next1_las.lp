% c4_v709_next1.lp
% Learning next/3.
% 

% Background knowledge -------------------------------------------------------
board_size(7,6).
col(X) :- X = 1..M, board_size(M,N).
row(Y) :- Y = 1..N, board_size(M,N).

% Roles / players -------------------------------------------------------------
role(1). role(2).

% Additional concepts --------------------------------------------------------
open(V1) :- cell(V1,V2-1,0).
open :- cell(V1,V2-1,0).

% Game state update  ---------------------------------------------------------- 
target(V1,V2) :- cell(V1,V2,0); not cell(V1,V2-1,0).
target(X,Y,P) :- does(P, drop(X)), cell(X,Y,0), not cell(X,Y-1,0).

% Legal moves: Actions --------------------------------------------------------
legal(V1,drop(V2)) :- control(V1); cell(V2,V3,0).

% Game state update  ----- TO BE LEARNED ------------------------------------ 
% next(X,Y,P) :- cell(X,Y,P), role(P).
% next(X,Y,P) :- target(X,Y,P).
% next(X,Y,0) :- cell(X,Y,0), not target(X,Y,_).

% Mode bias ------------------------------------------------------------------
#modeh(next(var(x),var(y),var(r))).
#modeh(next(var(x),var(y),0)).
#modeb(1, role(var(r))).
#modeb(1, control(var(r))).
#modeb(1, open).
#modeb(1, open(var(x))).
#modeb(1, target(var(x),var(y))).
#modeb(1, target(var(x),var(y),var(r))).
#modeb(1, cell(var(x),var(y),var(r))).
#modeb(1, cell(var(x),var(y),0)).
#modeb(1, cell(var(x),var(y)-1,0)).
#modeb(1, does(var(r), drop(var(x)))).
#modeb(1, legal(var(r), drop(var(x)))).
#maxv(3).

% Examples
#pos({
% . . . . . 2 .
% . . . 2 . 1 .
% . . 2 1 . 2 1
% . . 2 2 . 2 2
% . 1 1 1 . 1 1
% 1 2 2 1 . 2 1

next(1,6,0), next(2,6,0), next(3,6,0), next(4,6,0), next(5,6,0), next(6,6,2), next(7,6,0),
next(1,5,0), next(2,5,0), next(3,5,0), next(4,5,2), next(5,5,0), next(6,5,1), next(7,6,0),
next(1,4,0), next(2,4,0), next(3,4,2), next(4,4,1), next(5,4,0), next(6,4,2), cell(7,4,1),
next(1,3,0), next(2,3,0), next(3,3,2), next(4,3,2), next(5,3,0), next(6,3,2), cell(7,3,2),
next(1,2,0), next(2,2,1), next(3,2,1), next(4,2,1), next(5,2,0), next(6,2,1), next(7,2,1),
next(1,1,1), next(2,1,2), next(3,1,2), next(4,1,1), next(5,1,0), next(6,1,2), cell(7,1,1)
},{
                                                                 next(6,6,0),             
                                       next(4,5,0),              next(6,5,0), 
                          next(3,4,0), next(4,4,0),              next(6,4,0), next(7,4,0),
                          next(3,3,0), next(4,3,0),              next(6,3,0), next(7,3,0),
             next(2,2,0), next(3,2,0), next(4,2,0),              next(6,2,0), next(7,2,0),
next(1,1,0), next(2,1,0), next(3,1,0), next(4,1,0),              next(6,1,0), next(7,1,0), 

next(1,6,1), next(2,6,1), next(3,6,1), next(4,6,1), next(5,6,1), next(6,6,1), next(7,6,1),
next(1,5,1), next(2,5,1), next(3,5,1), next(4,5,1), next(5,5,1),              next(7,5,1),
next(1,4,1), next(2,4,1), next(3,4,1),              next(5,4,1), next(6,4,1),              
next(1,3,1), next(2,3,1), next(3,3,1), next(4,3,1), next(5,3,1), next(6,3,1), next(7,3,1),
next(1,2,1),                                        next(5,2,1),                           
             next(2,1,1), next(3,1,1),              next(5,1,1), next(6,1,1),              

next(1,6,2), next(2,6,2), next(3,6,2), next(4,6,2), next(5,6,2),              next(7,6,2),
next(1,5,2), next(2,5,2), next(3,5,2),              next(5,5,2), next(6,5,2), next(7,5,2),
next(1,4,2), next(2,4,2),              next(4,4,2), next(5,4,2),              next(7,4,2),
next(1,3,2), next(2,3,2),                           next(5,3,2),              
next(1,2,2), next(2,2,2), next(3,2,2), next(4,2,2), next(5,2,2), next(6,2,2), next(7,2,2),
next(1,1,2),                           next(4,1,2), next(5,1,2),              next(7,1,2),
does(1,drop(1)), does(1,drop(2)),does(1,drop(3)),does(1,drop(4)),does(1,drop(5)),does(1,drop(6)),does(1,drop(7))
    
    },{
% . . . . . 2 .
% . . . 2 . 1 .
% . . . 1 . 2 1
% . . 2 2 . 2 2
% . 1 1 1 . 1 1
% 1 2 2 1 . 2 1

cell(1,6,0). cell(2,6,0). cell(3,6,0). cell(4,6,0). cell(5,6,0). cell(6,6,2). cell(7,6,0).
cell(1,5,0). cell(2,5,0). cell(3,5,0). cell(4,5,2). cell(5,5,0). cell(6,5,1). cell(7,5,0).
cell(1,4,0). cell(2,4,0). cell(3,4,0). cell(4,4,1). cell(5,4,0). cell(6,4,2). cell(7,4,1).
cell(1,3,0). cell(2,3,0). cell(3,3,2). cell(4,3,2). cell(5,3,0). cell(6,3,2). cell(7,3,2).
cell(1,2,0). cell(2,2,1). cell(3,2,1). cell(4,2,1). cell(5,2,0). cell(6,2,1). cell(7,2,1).
cell(1,1,1). cell(2,1,2). cell(3,1,2). cell(4,1,1). cell(5,1,0). cell(6,1,2). cell(7,1,1).
control(2).
does(2,drop(3)).
}).

#pos({
% . . . . . 2 .
% . . . 2 . 1 .
% . . . 1 . 2 1
% . . 2 2 . 2 2
% . 1 1 1 . 1 1
% 1 2 2 1 . 2 1

next(1,6,0), next(2,6,0), next(3,6,0), next(4,6,0), next(5,6,1), next(6,6,0), next(7,6,0),
next(1,5,0), next(2,5,0), next(3,5,0), next(4,5,0), next(5,5,1), next(6,5,0), next(7,5,2),
next(1,4,0), next(2,4,2), next(3,4,0), next(4,4,0), next(5,4,2), next(6,4,0), next(7,4,2),
next(1,3,0), next(2,3,1), next(3,3,1), next(4,3,0), next(5,3,1), next(6,3,0), next(7,3,1),
next(1,2,0), next(2,2,2), next(3,2,1), next(4,2,0), next(5,2,2), next(6,2,1), next(7,2,2),
next(1,1,1), next(2,1,2), next(3,1,1), next(4,1,0), next(5,1,1), next(6,1,2), next(7,1,2)

},{
                                                    next(5,6,0),                                      
                                                    next(5,5,0),              next(7,5,0),
             next(2,4,0),                           next(5,4,0),              next(7,4,0),
             next(2,3,0), next(3,3,0),              next(5,3,0),              next(7,3,0),
             next(2,2,0), next(3,2,0),              next(5,2,0), next(6,2,0), next(7,2,0),
next(1,1,0), next(2,1,0), next(3,1,0),              next(5,1,0), next(6,1,0), next(7,1,0),

next(1,6,1), next(2,6,1), next(3,6,1), next(4,6,1),              next(6,6,1), next(7,6,1),
next(1,5,1), next(2,5,1), next(3,5,1), next(4,5,1),              next(6,5,1), next(7,5,1),
next(1,4,1), next(2,4,1), next(3,4,1), next(4,4,1), next(5,4,1), next(6,4,1), next(7,4,1),
next(1,3,1),                           next(4,3,1),              next(6,3,1),             
next(1,2,1), next(2,2,1),              next(4,2,1), next(5,2,1),              next(7,2,1),
             next(2,1,1),              next(4,1,1),              next(6,1,1), next(7,1,1),

next(1,6,2), next(2,6,2), next(3,6,2), next(4,6,2), next(5,6,2), next(6,6,2), next(7,6,2),
next(1,5,2), next(2,5,2), next(3,5,2), next(4,5,2), next(5,5,2), next(6,5,2),              
next(1,4,2),              next(3,4,2), next(4,4,2),              next(6,4,2),             
next(1,3,2), next(2,3,2), next(3,3,2), next(4,3,2), next(5,3,2), next(6,3,2), next(7,3,2),
next(1,2,2),              next(3,2,2), next(4,2,2),              next(6,2,2),              
next(1,1,2),              next(3,1,2), next(4,1,2), next(5,1,2)                           
},{    
% . . . . 1 . .
% . . . . 1 . 2
% . 2 . . 2 . 2
% . 1 . . 1 . 1
% . 2 1 . 2 1 2
% 1 2 1 . 1 2 2

cell(1,6,0). cell(2,6,0). cell(3,6,0). cell(4,6,0). cell(5,6,1). cell(6,6,0). cell(7,6,0).
cell(1,5,0). cell(2,5,0). cell(3,5,0). cell(4,5,0). cell(5,5,1). cell(6,5,0). cell(7,5,2).
cell(1,4,0). cell(2,4,2). cell(3,4,0). cell(4,4,0). cell(5,4,2). cell(6,4,0). cell(7,4,2).
cell(1,3,0). cell(2,3,1). cell(3,3,0). cell(4,3,0). cell(5,3,1). cell(6,3,0). cell(7,3,1).
cell(1,2,0). cell(2,2,2). cell(3,2,1). cell(4,2,0). cell(5,2,2). cell(6,2,1). cell(7,2,2).
cell(1,1,1). cell(2,1,2). cell(3,1,1). cell(4,1,0). cell(5,1,1). cell(6,1,2). cell(7,1,2).
control(1).
does(1,drop(3)). 

}).

% (base) ~/c4 % ilasp --version=2i c4_v709_next1_las.lp -ml=4
% next(V1,V2,V3) :- target(V1,V2,V3).
% next(V1,V2,V3) :- role(V3); cell(V1,V2,V3).
% next(V1,V2,0) :- control(V3); cell(V1,V2,0); not target(V1,V2,V3).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Pre-processing                          : 0.016s
% %% Hypothesis Space Generation             : 7.847s
% %% Counterexample search                   : 0.006s
% %%   - CDOEs                               : 0s
% %%   - CDPIs                               : 0.006s
% %% Hypothesis Search                       : 2.424s
% %% Total                                   : 10.332s
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%