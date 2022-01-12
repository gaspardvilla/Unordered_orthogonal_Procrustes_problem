function X = tricky_sort(A, B)
    % The idea of this function is to find a good initial transport matrix
    % X depending on the norm of each points in A and B.

    % Get the matrices XA and XB
    XA = re_order(A);
    XB = re_order(B);

    % Compute the final result
    X = XA' * XB;
end