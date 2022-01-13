function X_0 = smart_init_X(A, B)
    %% Description

    % The idea of this function is to initialize the optimal transport
    % matrix with a smart initialization by giving a permutation matrix
    % that link the points A and B in order of their norm.

    % A and B: two sets of n points in R^d (matrices of size n x d)


    %% Code

    % Get the matrices XA and XB
    XA = re_order(A);
    XB = re_order(B);

    % Direct computation
    X_0 = XA' * XB;
end


% --------------------------- %


function X = re_order(A)
    %% Description

    % This function order the matrix in the increasing order of the norm of
    % the n pints.

    % A: matrix of size n x d.
    

    %% Code
    
    % Initialization of some parameters
    s = size(A);
    n = s(1);
    X = eye(n);
    Id = eye(n);

    % Get the norm of the vectors in A
    norm_ = vecnorm(A, 2, 2);

    % Sort depending of the norm
    [norm_, idx] = sort(norm_);
    
    % Get the size norm
    size_norm = size(norm_);

    % Set the permuttaion matrix that sort against the norm
    for i = 1 : size_norm(1)
        X(i,:) = Id(idx(i), :);
    end
end