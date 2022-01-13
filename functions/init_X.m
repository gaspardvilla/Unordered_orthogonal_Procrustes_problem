function X_0 = init_X(A, B, options)
    %% Description

    % The idea of this function is to initialize the optimal transport
    % matric to a random doubly stochastic matrix or with a smart
    % initialization depending if we need it or not.

    % A and B: two sets of n points in R^d (matrices of size n x d)
    % options: object containing all the tuning parameters we can use for
    % this method.


    %% Code

    % Check if we want smart initialization or not
    if options.smart_init
        % Smart initialization
        X_0 = smart_init_X(A, B);
    else
        % Random initialization
        Manifold = multinomialdoublystochasticfactory(options.n);
        X_0 = Manifold.rand();
    end
end