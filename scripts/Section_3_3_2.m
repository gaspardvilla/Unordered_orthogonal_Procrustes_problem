%% Description

% The idea of this script is to produce the results of performances 
% we interpret in the section 3.3.2 of the report. 


%% Code
close all
clearvars
clc

%% Options setting
% Size of the sets
options.n = 10;
options.d = 2;

% Number of tests for the performances
% Set equal to 1 is you just want to test the method once
options.nb_tests = 100;

% Custom initialization
options.custom = "none";

% Smart initialization of the OT matrix X
options.smart_init = false;

% It is recommanded to not tune the following parameters
options.random = true;
options.verbosity = 0;

options.max_iters = 100;
options.stop_cond = 1e-3;

options.lambda_start = 1;
options.lambda_min = 1e-6;
options.alpha = 0.95;


%% Performances of the methods
% Initialization of the performances vector
accuracy_vect_intuitive = zeros(options.nb_tests, 1);
accuracy_vect_elegant = zeros(options.nb_tests, 1);
speed_vect = zeros(options.nb_tests, 1);

% Loop among all the tests
for test = 1 : options.nb_tests
    disp(['Test number ', num2str(test)]);

    % Init points and matrices
    [A, B, Q_true, X_true] = initialization(options);

    % Same initilization of X_0 for both methods
    options.X_init = init_X(A, B, options);

    % Intuitive method test
    tic
    [Q_intuitive, X_intuitive] = alt_intuitive(A, B, options);
    toc_intuitive = toc;
    accuracy_vect_intuitive(test) = good_approximation(Q_true', Q_intuitive);

    % Elegant method test
    tic
    [Q_elegant, X_elegant] = alt_elegant(A, B, options);
    toc_elegant = toc;
    accuracy_vect_elegant(test) = good_approximation(Q_true', Q_elegant);

    % Update the speed accuracy
    speed_vect(test) = toc_intuitive / toc_elegant;

end


%% Presentation of the performances

% Mean accuracy
mean_acc_int = mean(accuracy_vect_intuitive);
mean_acc_ele = mean(accuracy_vect_elegant);

% Mean diff speed
mean_speed = mean(speed_vect);

% Display the results
disp(['Alternating algo with intuive methods has accuracy of ', ...
        num2str(mean_acc_int)]);
disp(['Alternating algo with elegant methods has accuracy of ', ...
       num2str(mean_acc_ele)]);
disp(['Elegant methods is ', num2str(mean_speed), ' times faster than ' ...
       'intuitive methods.'])


%% Visualization of the last test
int_method = 'alternating algorithm for intuitive methods';
ele_method = 'alternating algorithm for elegant methods';
visualization_orth_transf(A, B, Q_intuitive, Q_elegant, options, ...
                                                int_method, ele_method);


