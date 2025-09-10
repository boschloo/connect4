% lunch_las_lp
% ILASP: An example
% TO LEARN: Take one or two items, but not the donut.

% Background
item(apple). item(pear). item(donut).

% Examples
% You can take just an apple, no pear.
#pos({take(apple)}, {take(pear)}).

% A combination is allowed, apple and pear for instance.
#pos({take(apple),take(pear) }, {}).

% Donuts are not fruits
#neg({take(donut)}, {}).

% At least one item should be taken
#neg({},{take(apple),take(pear),take(donut)}).

% Mode bias
#modeha(take(var(v))).
#modec(item(var(v))).
#modeb(1, item(var(v))).
#modeb(1, take(donut)).
#maxv(1).

% Output
% (base) ~/c4 % ilasp --version=2i lunch_las.lp
%  :- take(donut).
% 1 {take(V1) : item(V1) } 2.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Pre-processing                          : 0.036s
% %% Hypothesis Space Generation             : 0.008s
% %% Conflict analysis                       : 0.006s
% %%   - Negative Examples                   : 0.006s
% %% Counterexample search                   : 0.001s
% %%   - CDOEs                               : 0s
% %%   - CDPIs                               : 0s
% %% Hypothesis Search                       : 0.015s
% %% Total                                   : 0.07s
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% (base) ~/c4 % ilasp --version=4 lunch_las.lp                          
% 1 {take(V1) : item(V1) } 2 :- not take(donut).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Pre-processing                          : 0.025s
% %% Hypothesis Space Generation             : 0.018s
% %% Conflict analysis                       : 0.467s
% %%   - Negative Examples                   : 0.061s
% %%   - Positive Examples                   : 0.406s
% %% Counterexample search                   : 0.008s
% %%   - CDOEs                               : 0s
% %%   - CDPIs                               : 0.006s
% %% Hypothesis Search                       : 0.032s
% %% Total                                   : 0.553s
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%