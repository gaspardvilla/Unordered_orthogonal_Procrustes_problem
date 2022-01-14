function [A, B, Q, X] = initialization(options)
    %% Description

    % The idea for this function is to initialize tow sets of points that
    % are identical with one rotation. 
    % We also get the rotation matrix to compare with the result we will
    % obtain at the end of our method.
    
    % options: object containing all the tuning parameters we can use for
    % this method.
    
    
    %% Code

    % If we want a custom initialization with a pattern for the points in A
    if strcmp(options.custom, 'waves') || strcmp(options.custom, 'spirale')
        % The custom initialization impact also the orthogonal matrix Q and
        % the number of points we will have in our data set.
        [A, Q, options.n] = custom_init(options);

    % Random initialization
    else
        % First set of points
        A = (rand(options.n, options.d) * 2) - 1;
        Manifold = stiefelfactory(options.d, options.d);
        Q = Manifold.rand();
    end

    % Centers the mass center of the points in A
    A = mass_centering(A);
    
    % Initialization of B
    B = A;

    % Randomize the points between A and B (normally always true)
    Id = eye(options.n);
    X = Id;
    if options.random
        idx = randperm(options.n);
        for ind = 1 : options.n
            B(ind, :) = A(idx(ind), :);
            X(idx(ind), :) = Id(ind, :);
        end
    end
    
    % Second set of points that is equivalent to A with rotation maytrix Q
    B = B * Q;
end