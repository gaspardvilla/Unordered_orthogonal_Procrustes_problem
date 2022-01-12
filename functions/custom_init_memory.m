function [A, Q, n] = custom_init_memory(d)
    % The idea of this function is to create a customized initialization
    % with hard case that will test the robustness of the algorithm.

    % Remark: for now, the initialization was set for 2D sample of points.


    % Re-initialziation of n
    n = 20;

    % Initialization
    x1 = [-1/2, 0];
    x2 = [1, 0];

    % Initialization of the matrix A
    A = zeros(n, d);

    for i = 1 : n/2
        % Random angle
        teta = unifrnd(-pi/4, pi/4);

        % rotation matrix
        R = rot_matrix_2D(teta);

        % update
        A(i, :) = x1 * R;
        A(i + n/2, :) = x2 * R;
    end

    % Matrix Q
    Q = rot_matrix_2D(pi);
end