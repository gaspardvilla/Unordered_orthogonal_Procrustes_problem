function [A, Q, n] = custom_init(custom, d)
    % The idea of this function is to create a customized initialization
    % with hard case that will test the robustness of the algorithm.

    % Remark: for now, the initialization was set for 2D sample of points.

    % Waves form
    if strcmp(custom, 'waves')
        % Re-initialziation of n
        n = 100;
    
        % Initialization of the matrix A
        A = zeros(n, d);

        for i = 1 : n
            % Random angle
            teta = unifrnd(-pi, pi);
    
            % update
            A(i, 1) = teta;
            A(i, 2) = abs(sin(teta));
        end

    % Spirale form
    elseif strcmp(custom, 'spirale')
        % Initailization
        n = 100;
        A = zeros(n, d);
        pos = [0, 0; 1, 0];
        nb_turns = 2;

        % Yolo
        dp = diff(pos, 1, 1);
        R = hypot(dp(1), dp(2));

        phi0 = atan2(dp(2), dp(1));
        phi = linspace(0, nb_turns * 2 * pi, n);
        r = linspace(0, R, n);
        
        size(r)

        A(:, 1) = pos(1,1) + r .* cos(phi + phi0);
        A(:, 2) = pos(1,2) + r  .* sin(phi + phi0);
    end

    % Add some noise
    for i = 1 : n
        A(i, :) = awgn(A(i,:),40);
    end

    % Matrix Q
    Q = rot_matrix_2D(pi);
end