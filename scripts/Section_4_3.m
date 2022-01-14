%% Description

% The idea of this script is to produce the results of performances 
% we interpret in the section 4.2.2 of the report. 


%% Code
close all
clearvars
clc

%% Options setting
% Size parameters setting
options.n = 10;
options.d = 2;

% Number of tests for the performances
% Set equal to 1 is you just want to test the method once
options.nb_tests = 100;

% It is recommanded to not tune the following parameters
% Custom set of points
options.custom = "none";

options.random = true;
options.verbosity = 0;

options.max_iters = 100;
options.stop_cond = 1e-3;

% Number of methods tp test (only 1 here)
options.nb_methods = 1;

% We want entropic regularizer
options.entropic_reg = true;
options.epsilon = 1e-1;

% If true precise which inialization you want for Q and X
options.custom_init = false;


%% Performances of the method
% Initialization of the performances vector
accuracy_vect = zeros(options.nb_tests, 1);


% Loop among all the tests
for test = 1 : options.nb_tests
    disp(['Test number ', num2str(test)]);

    % Init points and matrices
    [A, B, Q_true, X_true] = initialization(options);

    % Intuitive method test
    Q_sol = one_variable_method(A, B, options);
    accuracy_vect(test) = good_approximation(Q_true', Q_sol);

end


%% Presentation of the performances

% Mean accuracy
mean_acc = mean(accuracy_vect);

% Display the results
disp(['Joint method fro one-variable problem has accuracy of ', num2str(mean_acc)]);


%% Visualization of the last test
options.method_name_1 = 'one-variable problem';
options.Q_1 = Q_sol;
visualization_orth_transf(A, B, options);


