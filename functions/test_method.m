function test_method(A, B, options)
    % The idea of this function is to test the 'method' under the different
    % parameters defined in options

    
    %% Initialization

    % Initialization of some parameters
    s = size(A);
    n = s(1);
    d = s(2);


    % Initilization under options
    if options.wrong_init
        if strcmp(options.problem, 'procruste')
            M = multinomialdoublystochasticfactory(n);
            X0 = M.rand();
        else
            Q0 = eye(d);
        end
    else
        if strcmp(options.problem, 'procruste')
            X0 = options.X0;
        else
            Q0 = options.Q0;
        end
    end



    %% Test method

    if options.perso
        if strcmp(options.problem, 'procruste')
            % Designed method for Procruste problem
            Q_t = perso_procruste(A, B, X0);
            X_t = X0;
    
        elseif strcmp(options.problem, 'ot')
            % Designed method for Sinkhorn problem
            C = cost_matrix(A, B * Q0);
            X_t = perso_ot(C);
            Q_t = Q0;

        else
            disp('ERROR: none problem was implemented, please chose between -- procruste -- or -- ot --.')
        end
    else
        if strcmp(options.problem, 'procruste')
            % MIT method for Procruste problem
            Q_t = mit_procruste(A, B, X0);
            X_t = X0;

        elseif strcmp(options.problem, 'ot')
            % MIT method for Sinkhorn problem
            C = cost_matrix(A, B * Q0);
            X_t = mit_ot(C, options.lambda);
            Q_t = Q0;

        else
            disp('ERROR: none problem was implemented, please chose between -- procruste -- or -- ot --.')
        end
    end



    %% Visualization
    if strcmp(options.problem, 'procruste')
        visualization_3_sets(A, B, B * Q_t);
    else
        visualization_2_sets(A, B, X_t, options);
    end


    % Print the final cost for comparison between MIT and personal method
    disp(['Final cost function value: ', num2str(inner_product(cost_matrix(A, B*Q_t), X_t))])
end









