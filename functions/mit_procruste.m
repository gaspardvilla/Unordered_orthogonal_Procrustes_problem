function Q = mit_procruste(A, B, X)
    % This function is the method from the MIT paper that solve the 
    % Procruste problem.

    % Compute the solution of the procruste problem
    [U, S, V] = svd(A' * X * B);
    sigma = diag(S);
    s = sign(sigma);
    Q = V * diag(s) * U';
end