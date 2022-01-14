function truth = good_approximation(Q_true, Q_approx)
    %% Description

    % The idea of this function is to know if the orthogonal matrix 
    % Q_approx found by an an algorithm is a close approximation of the
    % true orthogonal matrix Q_true.

    % Q_true: the real orthogonal matrix of size d x d
    % Q_approx: an approximation of Q_true of size d x d


    %% Code

    % Initialization
    truth = 0;

    % Check if the approximation is close or not 
    if sum(abs(Q_true - Q_approx), 'all') < 1e-1
        truth = 1;
    end
end