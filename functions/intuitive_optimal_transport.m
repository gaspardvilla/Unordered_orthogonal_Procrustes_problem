function X_sol = intuitive_optimal_transport(A, B, Q, options)
    %% Description

    % The idea of this function is to apply the RCGD method to find an
    % approximation of the optimal transport matrix by fixing the
    % orthogonal matrix Q.

    % A and B: two sets of n points in R^d (matrices of size n x d)
    % Q: fixed orthogonal matrix
    % options: object containing all the tuning parameters we can use for
    % this method.


    %% Code

    % Initialization of n
    n = options.n;

    % Create the problem of the optimal transport
    Manifold = multinomialdoublystochasticfactory(n);
    problem_ot.M = Manifold;

    % Compute the cost matrix
    C = cost_matrix(A, B*Q);

    % Specify function and derivatives
    problem_ot.cost = @(X) inner_product(C, X);
    problem_ot.egrad = @(X) C;
    
    % Compute the optimal transport solution
    options_ot.verbosity = options.verbosity;

    % Initialize the matrix X_init
    X_init = Manifold.rand();

    % Apply RCGD method
    [X_sol, ~, ~, ~] = conjugategradient(problem_ot, X_init, options_ot);
end


