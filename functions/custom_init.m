function [A, Q, n] = custom_init(options)
    %% Description

    % The idea of this function is to create a customized initialization
    % with pattern in our data set of points.

    % options: object containing all the tuning parameters we can use for
    % this method.


    %% Code

    % Waves form
    if strcmp(options.custom, 'waves')
        % Re-initialziation of n
        n = 100;
    
        % Initialization of the matrix A
        A = zeros(n, options.d);

        for i = 1 : n
            % Random angle
            teta = unifrnd(-pi, pi);
    
            % Update
            A(i, 1) = teta;
            A(i, 2) = abs(sin(teta));
        end

    % Spirale form
    elseif strcmp(options.custom, 'spirale')
        % Initailization
        n = 100;
        A = zeros(n, options.d);
        pos = [0, 0; 1, 0];
        nb_turns = 2;

        % Build the spirale
        dp = diff(pos, 1, 1);
        R = hypot(dp(1), dp(2));

        phi0 = atan2(dp(2), dp(1));
        phi = linspace(0, nb_turns * 2 * pi, n);
        r = linspace(0, R, n);

        % Update the matrix A
        A(:, 1) = pos(1,1) + r .* cos(phi + phi0);
        A(:, 2) = pos(1,2) + r  .* sin(phi + phi0);
    end

    % Add some noise, to be sure that the pattern is exactly the smae each
    % time
    for i = 1 : n
        A(i, :) = awgn(A(i,:),40);
    end

    % Matrix Q
    Q = rot_matrix_2D(pi);
end