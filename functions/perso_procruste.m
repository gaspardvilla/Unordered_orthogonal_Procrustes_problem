function Q = perso_procruste(A, B, X)
    % This function is the designed function that solve the Procruste 
    % problem in our way.

    % init 
    s = size(A);
    d = s(2);

    % Create the problem for the rotation matrices
    M = rotationsfactory(d);
    problem_so.M = M;
    
    % Specify cost function and derivatives
    problem_so.cost = @(Q) trace(cost_matrix(A, B*Q)' * X);
    problem_so.egrad = @(Q) -2 * B' * X' * A;  % Euclidean gradient
    
    % Step-size (to see if we use backtracking)
    % alpha = backtracking(Q_t, 1, problem_so);
    options.verbosity = 0;
    Q_ = M.rand();
    Q = conjugategradient(problem_so, Q_, options);
    
end