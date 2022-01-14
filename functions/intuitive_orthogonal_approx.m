function Q_sol = intuitive_orthogonal_approx(A, B, X, options)
    %% Description

    % The idea of this function is to apply the RCGD method to find an
    % approximation of the orthogonal matrix Q_true by fixing the optimal
    % transport matrix X.

    % A and B: two sets of n points in R^d (matrices of size n x d)
    % X: fixed optimal transport matrix
    % options: object containing all the tuning parameters we can use for
    % this method.


    %% Code

    % Initialization of d
    d = options.d;

    % Create the problem for the orthogonal matrices O(d) = Stiefel(d, d)
    Manifold = stiefelfactory(d, d);
    problem_orth.M = Manifold;
    
    % Specify cost function and derivatives
    problem_orth.cost = @(Q) inner_product(cost_matrix(A, B*Q), X);
    problem_orth.egrad = @(Q) -2 * B' * X' * A;
    
    % Set the verbosity
    options_rcgd.verbosity = options.verbosity;

    % Initialize the matrix Q_init
    Q_init = Manifold.rand();

    % Apply RCGD method
    Q_sol = conjugategradient(problem_orth, Q_init, options_rcgd);
end


