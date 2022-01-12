function X = perso_ot(C)
    % This function computes the optimal transport from A to B*Q that are 
    % represented by this cost matrix C. (personnal method)

    % The matrix X_ is of size n x n and represent the previous optimal
    % transport. (Maybe remove it, and use each time a random optimal
    % transport ?)

    % Initialization of some parameters
    s = size(C);
    n = s(1);

    % Create the problem of the optimal transport
    M = multinomialdoublystochasticfactory(n);
    problem_ot.M = M;
    
    % Specify function and derivatives
    problem_ot.cost = @(X) trace(C' * X); % implémenter qqch de plus efficace
    problem_ot.egrad = @(X) C;
    
    % Compute the optimal transport solution
    options.verbosity = 0;
    X_ = M.rand();
    [X, ~, ~, ~] = conjugategradient(problem_ot, X_, options);

end