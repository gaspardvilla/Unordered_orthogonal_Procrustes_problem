function h = entropic_regularizer(X)
    %% Description

    % This function computes the entropic regularization value.

    
    %% Code

    % Get size of X
    s = size(X);
    n = s(1);

    % Direct computation
    X_ = X .* (log(X) - ones(n, n));
    h = (-1) * sum(X_, "all");
end