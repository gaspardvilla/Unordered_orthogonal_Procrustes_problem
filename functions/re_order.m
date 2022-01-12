function X = re_order(A)
    % This function order the matrix in the increasing order of the norm of
    % the n pints. (knowing that the dimension of A is equla to n x d.

    % Initailization
    s = size(A);
    n = s(1);

    X = eye(n);
    Id = eye(n);

    norm_ = vecnorm(A, 2, 2);
    [norm_, idx] = sort(norm_);

    s_norm = size(norm_);

    for i = 1 : s_norm(1)
        X(i,:) = Id(idx(i), :);
    end
end