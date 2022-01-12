function C = cost_matrix(A, B)
    % The idea of this fucntion is to compute matrix that summarize the
    % distance between all the points in A to the points in B. We call this
    % matrix C the cost matrix of A and B.
    
    % Get some parameters
    s = size(A);
    N = s(1);
    
    
    % Initialization
    Ga = A * A';
    Gb = B * B';
    Gab = A * B';
    
    % Computation
    C = (diag(Ga) * ones(1, N)) + ...
        (ones(N, 1) * diag(Gb)') - (2 * Gab);
end