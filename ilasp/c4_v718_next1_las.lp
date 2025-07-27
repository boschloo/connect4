% c4_v718_next1_las.lp
% To learn next/1.
% 

board_size(7,6).
role(1). role(2). 

% Predicate numberOf/2 ----------------------------
count(1,0,P,0) :- role(P).
count(X,Y,P,N) :- count(X,Y-1,P,N-1), cell(X,Y,P).
count(X,1,P,N) :- count(X-1,Y-1,P,N-1), not cell(X-1,Y,_), cell(X,1,_), cell(X,1,P).
count(X,Y,P,N) :- count(X,Y-1,P,N), cell(X,Y,_), not cell(X,Y,P).
count(X,1,P,N) :- count(X-1,Y-1,P,N), not cell(X-1,Y,_), cell(X,1,_), not cell(X,1,P).
numberOf(P,N) :- count(X,Y,P,N), board_size(X,Y).

% Mode bias
#modeh(control(var(r))).
#modeh(next(control(var(r)))).
#modeb(1, role(var(r))).
#modeb(2, control(var(r))).
#modeb(1, next(control(var(r)))).
#modeb(1, next(control(const(c)))).
#modeb(2, numberOf(var(r),var(n))).
#modeb(1, board_size(var(x),var(y))).
#modeb(2, var(n) < var(n)).
#modeb(2, var(r) < var(r)).

constant(c,0).
constant(c,1).
constant(c,2).

#maxv(3).

% Examples
#pos({next(control(1))},{next(control(2)), next(control(0))},{control(2).}).
#pos({next(control(2))},{next(control(1)), next(control(0))},{control(1).}).
#neg({next(control(1)),next(control(2))},{},{}).

% (base) ~/c4 % ilasp --version=2i c4_v718_next1_las.lp
% next(control(V1)) :- role(V1); control(V2); not control(V1).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Pre-processing                          : 0.034s
% %% Hypothesis Space Generation             : 0.102s
% %% Conflict analysis                       : 0.014s
% %%   - Negative Examples                   : 0.014s
% %% Counterexample search                   : 0.007s
% %%   - CDOEs                               : 0s
% %%   - CDPIs                               : 0.007s
% %% Hypothesis Search                       : 0.065s
% %% Total                                   : 0.223s
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%