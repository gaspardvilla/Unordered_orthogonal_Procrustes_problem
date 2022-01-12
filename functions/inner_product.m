function inn = inner_product(A, B)
    % The idea of this function is to compute the inner product between the
    % matrices A and B
    
    % Direct computation
    inn = trace(A' * B);
end