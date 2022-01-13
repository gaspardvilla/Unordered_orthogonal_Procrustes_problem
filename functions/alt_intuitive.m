function [Q_sol, X_sol] = alt_intuitive(A, B, options)
    %% Description

    % The idea of this function is to compute the approximation of the
    % orthogonal matrix Q_true that differenciates the sets of points A and
    % B, knowing that A and B are not ordered. The method used here is the
    % alternating methods with intuitive solver for the two sub-problems.

    % A and B: two sets of n points in R^d (matrices of size n x d)
    % options: object containing all the tuning parameters we can use for
    % this method.


    %% Code

    % Initialization of X_t
    X_t = options.X_init;

    % First step
    Q_t = intuitive_orthogonal_approx(A, B, X_t, options);

    % Loop until reaching the maximum number of iterations
    for iter = 1 : options.max_iters

        % Alternating method
        X_t = intuitive_optimal_transport(A, B, Q_t, options);
        Q_t = intuitive_orthogonal_approx(A, B, X_t, options);
        
        % Break rule
        if inner_product(cost_matrix(A, B*Q_t), X_t) < options.stop_cond
            break;
        end
    end

    % Set the final solutions
    Q_sol = Q_t;
    X_sol = X_t;
end


