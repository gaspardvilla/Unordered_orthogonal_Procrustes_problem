function inn = inner_product(A, B)
    %% Description

    % The idea of this function is to compute the inner product between the
    % matrices A and B (equal to trace(A' * B)) in an efficient way, i.e.
    % without calculating the product A' * B that is expensive. 

    % A and B: two matrices of size n x d


    %% Code
    
    % Initalization of some parameters
    inn = 0;
    s = size(A);
    d = s(2);

    % Loop among all the diagonal elements
    for idx = 1 : d
        scalar_prod = A(:, idx)' * B(:, idx);
        inn = inn + scalar_prod;
    end
end