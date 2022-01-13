function C = cost_matrix(A, B)
    %% Description

    % The idea of this fucntion is to compute matrix that summarize the
    % squared distances between all the points in A to the points in B.
    % We call this matrix C the cost matrix of A and B.
    
    % Get some parameters
    s = size(A);
    N = s(1);

    
    %% Code
    
    % Initialization
    AA = A * A';
    BB = B * B';
    AB = A * B';
    
    % Direct computation
    C = (diag(AA) * ones(1, N)) + (ones(N, 1) * diag(BB)') - (2 * AB);
end