function [Q_sol, X_sol] = joint_method(A, B, options)
    %% Description

    % This function computes the conjugate gradient method jointly for the
    % matrices Q and X.

    % A and B: two sets of n points in R^d (matrices of size n x d)
    % options: object containing all the tuning parameters we can use for
    % this method.


    %% Code

    % Initialization of n and d
    n = options.n;
    d = options.d;

    % We pose the problem instance
    M1 = stiefelfactory(d, d);
    M2 = multinomialdoublystochasticfactory(n);

    % Fix the manifold for X and Q variable
    manifold.X = M2;
    manifold.Q = M1;
    
    % Construct the product of manifolds
    problem.M = productmanifold(manifold);

    % Check if we want the function with the entropic regularizer added
    if options.entropic_reg
        eps = options.epsilon;

        % Set the cost function
        problem.cost = @(Z) inner_product(cost_matrix(A, B * Z.Q), Z.X) - ...
                                                (eps * entropic_regularizer(Z.X));

        % Set the Euclidean gradient
        problem.egrad = @(Z) struct('X', cost_matrix(A, B * Z.Q) + ...
                                (eps * log(Z.X)), 'Q', -2 * B' * Z.X' * A);
        
    else
        % Set the cost function
        problem.cost = @(Z) inner_product(cost_matrix(A, B * Z.Q), Z.X);

        % Set the Euclidean gradient
        problem.egrad = @(Z) struct('X', cost_matrix(A, B * Z.Q), ...
                                                    'Q', -2 * B' * Z.X' * A);
    end

    checkgradient(problem);

    % In the case of custom initialization
    if options.custom_init
        X_init = options.X_init;
        Q_init = options.Q_init;
    else
        X_init = M2.rand();
        Q_init = M1.rand();
    end

    % Initialize the structure variable Z
    Z_init = struct('X', X_init, 'Q', Q_init);

    % Solve the problem with RCGD method
    options_.verbosity = options.verbosity;
    [Z_sol, ~, ~] = conjugategradient(problem, Z_init, options_);
    
    % Get back the solution from the structure
    Q_sol = Z_sol.Q;
    X_sol = Z_sol.X;
end