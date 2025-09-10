item(apple; pear; banana; donut).  % syntactic sugar added
1 { take(V1) : item(V1) } 2.
:- take(donut).
left(X) :- not take(X), item(X).
#show take/1.
#show left/1.

% Listing 1: lunch.lp - ASP demo program

% clingo version 5.4.0
% Reading from /Users/boschloo/c4/lunch.lp
% Solving...
% Answer: 1
% left(donut) left(apple) take(pear) left(banana)
% Answer: 2
% left(donut) left(apple) left(pear) take(banana)
% Answer: 3
% left(donut) left(apple) take(pear) take(banana)
% Answer: 4
% left(donut) take(apple) left(pear) left(banana)
% Answer: 5
% left(donut) take(apple) left(pear) take(banana)
% Answer: 6
% left(donut) take(apple) take(pear) left(banana)
% SATISFIABLE

% Models       : 6
% Calls        : 1
% Time         : 0.006s (Solving: 0.00s 1st Model: 0.00s Unsat: 0.00s)
% CPU Time     : 0.002s

% Listing 2: lunch.lp - ASP demo program, output
