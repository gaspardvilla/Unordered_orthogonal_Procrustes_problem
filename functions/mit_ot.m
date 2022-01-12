function X = mit_ot(C, lambda)
    % This function computes the optimal transport from A to B*Q that are 
    % represented by this cost matrix C. (MIT method)

    % Initialization of some parameters
    s = size(C);
    n = s(1);

    p = ones(n,1);
    q = p;

    % Solve the OT via Sinkhorn iterations
    b = ones(n, 1);
    a = ones(n, 1);
    K = exp(-C / lambda);

    % Initialization of stopping condition matrix
    stop_cond = 1;

    % Loop for the Sinkhorn algorithm
    while norm(stop_cond, 1) > 1e-5

        % Keep in memory the a
        a_ = a;

        % Update a and b
        a = p ./ (K * b);
        b = q ./ (K' * a);

        % Update stopping condition
        stop_cond = ((a_ ./ a) .* p) - p;
    end

    % Update the transport matrix
    X = diag(a) * K * diag(b);

end