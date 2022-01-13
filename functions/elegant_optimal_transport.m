function X_sol = elegant_optimal_transport(A, B, Q, options)
    %% Description

    % The idea of this function is to apply the Sinkhorn's algorithm
    % to find an approximation of the optimal transport matrix by fixing 
    % the orthogonal matrix Q.

    % A and B: two sets of n points in R^d (matrices of size n x d)
    % Q: fixed orthogonal matrix
    % options: object containing all the tuning parameters we can use for
    % this method.


    %% Code

    % Initialization of some parameters
    n = options.n;

    p = ones(n, 1);
    q = p;

    b = ones(n, 1);
    a = ones(n, 1);

    % Compute the cost matrix
    C = cost_matrix(A, B*Q);

    % Compute the matrix K
    K = exp(-C / options.lambda);

    % Initialization of stopping condition
    stop_cond = 1;

    % Loop for the Sinkhorn algorithm
    while norm(stop_cond, 1) > 1e-5

        % Keep in memory the a
        a_ = a;

        % Update a and b
        a = p ./ (K * b);
        b = q ./ (K' * a);

        % Update stopping condition
        stop_cond = ((a_ ./ a) .* p) - p;
    end

    % Final computation of the result
    X_sol = diag(a) * K * diag(b);
end


