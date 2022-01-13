close all
clearvars
clc


% The idea here is to test one by one all the substeps of our methods, with
% different initialization to check wether the methods are well
% implemented. With we can debug our code and observe how the different
% methods occurs to solve our problem. The main idea is to compare our
% designed method (using optimization on manifolds) with the methods
% proposed by the MIT.



%% Initialization

% Initialization of the sample points
n = 10;
d = 2;
random = true;
custom = 'waves';
[A, B, Q_true, X_true] = initialization(n, d, random, custom);

% Initialization of the method we want to test
options = options_init('perso ot', Q_true, X_true);
options.wrong_init = false;


%% Testing the method
test_method(A, B, options);







