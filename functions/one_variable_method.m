function Q_sol = one_variable_method(A, B, options)
    %% Description

    % The idea of this function is to apply the joint method by expressing
    % the variable X in function of Q, i.e. we bring back the problem to a
    % one-variable problem.

    % A and B: two sets of n points in R^d (matrices of size n x d)
    % options: object containing all the tuning parameters we can use for
    % this method.


    %% Code
    % Initialization of the manifolds
    Manifold = stiefelfactory(options.d, options.d);
    
    % Create the instance problem
    problem.M = Manifold;
    
    % Setting the coost function
    problem.cost = @(Q) inner_product(cost_matrix(A, B*Q), ...
                            intuitive_optimal_transport(A, B, Q, options));
    
    % Setting the approximation of the euclidean gradient
    problem.egrad = @(Q) -2 * B' * ...
                        intuitive_optimal_transport(A, B, Q, options)' * A;
    
    % Verbosity setting
    options.verbosity = 0;

    % Fix the initialization and solve the problem
    Q_init = Manifold.rand();
    Q_sol = conjugategradient(problem, Q_init, options);
end