close all
clearvars
clc

%% Introduction

% The idea of this script is to design a new way to compute the optimal
% solution of our problem depending on two variables, using only one of
% them. This will maybe lead us to a quasi-convex problem to solve and
% maybe avoid to fall into local minima.


%% Initialization

% Initialization of the problem
n = 10;
d = 2;
random = true;
custom = 'none';
[A, B, Q_true, X_true] = initialization(n, d, random, custom);

M1 = rotationsfactory(d);
M2 = multinomialdoublystochasticfactory(n);

%% Wait 

problem.M = M1;

problem.cost = @(Q) trace(cost_matrix(A, B*Q)' * compute_X(A, B, Q, n));
problem.egrad = @(Q) -2 * B' * compute_X(A, B, Q, n)' * A;

checkgradient(problem)

options.verbosity = 0;
Q_ = M1.rand();
Q = conjugategradient(problem, Q_, options);
visualization_3_sets(A, B, B*Q, custom);


%% LoopRing

% % Set the initialization
% 
% 
% while stop_cond
%     
%     % If not a descent direction
% 
% 
%     % Line search for the step-size
% 
% 
%     % Computation of X k+1
% 
% 
%     % Computation of beta k+1
% 
% 
%     % Update U k+1
% 
% 
% end








