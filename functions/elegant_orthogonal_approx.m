function Q_sol = elegant_orthogonal_approx(A, B, X)
    %% Description

    % The idea of this function is to apply the generalized Procrustes
    % problem to find an approximation of the orthogonal matrix Q_true
    % by fixing the optimal transport matrix X.

    % A and B: two sets of n points in R^d (matrices of size n x d)
    % X: fixed optimal transport matrix


    %% Code

    % Direct application of the lemma
    % Computation of the SVD
    [U, S, V] = svd(A' * X * B);

    % Get the diagonal of S and the sign of these values
    sigma = diag(S);
    sign_sigma = sign(sigma);

    % Direct computation
    Q_sol = V * diag(sign_sigma) * U';
end


