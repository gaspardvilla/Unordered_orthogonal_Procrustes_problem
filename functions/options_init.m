function options = options_init(problem, Q_true, X_true)
    % This function gives an initialization for the options for different
    % kind of problems.

    % Initialization
    options.X_true = X_true;
    options.Q_true = Q_true;
    options.problem = problem;

    % Get some conditions
    if strcmp(problem, 'perso procruste')
        options.perso = true;
        options.problem = 'procruste';
        options.wrong_init = false;
        options.X0 = X_true;
       
    elseif strcmp(problem, 'perso ot')
        options.perso = true;
        options.problem = 'ot';
        options.wrong_init = false;
        options.Q0 = Q_true';

    elseif strcmp(problem, 'mit procruste')
        options.perso = false;
        options.problem = 'procruste';
        options.wrong_init = false;
        options.X0 = X_true;

    elseif strcmp(problem, 'mit ot')
        options.perso = false;
        options.problem = 'ot';
        options.wrong_init = false;
        options.Q0 = Q_true';
        options.lambda = 1e-1;

    else
        disp('ERROR: the problem string is not on a good form.');

    end
end