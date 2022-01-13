close all
clearvars
clc


% The idea here is just to try (again) the alternative method.



%% Initialization

% Initialization of the sample points
n = 10;
d = 2;
random = true;
custom = 'none';
if strcmp(custom, 'waves') || strcmp(custom, 'spirale')
    n = 100;
end
[A, B, Q_true, X_true] = initialization(n, d, random, custom);
max_iters = 100;

perso = true;

TRICK = false;

comparison = false;

% Initialization of lambda
lambda = 1;
alpha = 0.95;
lambda_min = 1e-6;


%% Testing the method

% Iterate on the number of times you want to test the same problem
epoch = 1;
pass_ = false;

while epoch < 2

    % Initialization of X_t
    M = multinomialdoublystochasticfactory(n);
    X_t = M.rand();
    
    % Tricky part
    if TRICK
        X_t = tricky_sort(A, B);
    end
    
    % First Procruste step
    Q_t = perso_procruste(A, B, X_t);
    
    % Loop on the maximum of iterations
    for iter = 1 : max_iters
    
        % if we want to use personal method
        if perso
            X_t = perso_ot(cost_matrix(A, B*Q_t));
            Q_t = perso_procruste(A, B, X_t);
    
        % if we want to use MIT method
        else
            X_t = mit_ot(cost_matrix(A, B*Q_t), lambda);
            Q_t = mit_procruste(A, B, X_t);
            lambda = max(lambda_min, lambda * alpha);
        end
    
    
        % Display at each step the evaluated cost function
        disp(['Cost function value: ', num2str(inner_product(cost_matrix(A, B*Q_t), X_t))])
        
        % Break rule
        if inner_product(cost_matrix(A, B*Q_t), X_t) < 1e-3
            break;
        end
    end
    
    
    %% Visualization
    visualization_3_sets(A, B, B*Q_t, custom);


    %% Upgrade the epoch
    if comparison && ~pass_
        epoch = 0;
        TRICK = true;
        pass_ = true;
    end

    epoch = epoch + 1;
end







