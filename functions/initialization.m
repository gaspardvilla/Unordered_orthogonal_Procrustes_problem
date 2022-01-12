function [A, B, Q, X] = initialization(n, d, random, custom)
    % The idea for this fucntion is to initialize tow sets of points that
    % are identical with one rotation. 
    % We also get the rotation matrix to compare with the result we will
    % obtain at the end of our method.
    
    % n is the number of points
    % d is the dimension of the space
    


    % Custom initialization

    % Waves forms (ideal for OT test) or spirale form (ideal for common problem)
    if strcmp(custom, 'waves') || strcmp(custom, 'spirale')
        [A, Q, n] = custom_init(custom, d);
        A = mass_centering(A);

    % Random initialization
    else
        % First set of points
        A = (rand(n, d) * 2) - 1;
        A = mass_centering(A);
        
        % Initialize a rotation matrix
        Q = randrot(d);
    end
    
    % Initialization of B
    B = A;

    % Randomize the points between A and B
    Id = eye(n);
    X = Id;
    if random
        idx = randperm(n);
        for i = 1 : n
            B(i, :) = A(idx(i), :);
            X(idx(i), :) = Id(i, :);
        end
    end
    
    % Second set of points that is equivalent to A with rotation maytrix Q
    B = B * Q;
end