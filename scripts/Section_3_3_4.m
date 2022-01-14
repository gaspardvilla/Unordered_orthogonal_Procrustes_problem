%% Description

% The idea of this script is to produce the results of performances 
% we interpret in the section 3.3.2 of the report. 


%% Code
close all
clearvars
clc

%% Options setting
% Number of grid points
options.nb_grid_pts = 100;

% It is recommanded to not tune the following parameters
% Size of the sets
options.n = 10;
options.d = 3;

% Custom set of points
options.custom = "none";

options.random = true;
options.verbosity = 0;

options.max_iters = 100;
options.stop_cond = 1e-3;

options.lambda = 1e-1;

% Initialization of the data sets of points
[A, B, Q_true, X_true] = initialization(options);


%% Apply method for each rotation
% Definition of the grid
x = linspace(0, 2*pi, options.nb_grid_pts);
[alpha_X, alpha_Y] = meshgrid(x, x);

% Initialization of the cost function grid
cost_grid = 0 * alpha_X;

% Initialization of nb of steps
step_nb = 0;

% Loop along the grid
for i = 1 : length(alpha_X)
    for j = 1 : length(alpha_Y)

        % Displays actual step
        step_nb = step_nb + 1;
        disp(['Step number : ', num2str(step_nb), ' / ', ...
                                         num2str(options.nb_grid_pts^2)])

        % Set the angles of the spherical coordinates
        phi = alpha_X(i, j);
        teta = alpha_Y(i, j);

        % get the corresponding 3D matrix
        Q_0 = rot_matrix_3D(phi, teta);

        % Compute the cost matrix
        C = cost_matrix(A, B * Q_0);

        % Compute the Sinkhorn's algorithm to find optimal transport matrix
        X_t = elegant_optimal_transport(A, B, Q_0, options);
        
        % Update the cost value
        cost_grid(i, j) = inner_product(C, X_t);
    end
end

%% Visualization 3D 
MIT = surf(alpha_X, alpha_Y, cost_grid);
axis padded
hold on
xlabel('phi');
ylabel('teta');
zlabel('cost function value');
title({['Visualization of the cost function after solving OT problem with ' ...
    'Sinkhorn s algorithm depending '], ['of the spherical coordinates of ' ...
    'the initialization of Q']});


