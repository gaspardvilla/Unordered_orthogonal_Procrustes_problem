function R = rot_matrix_2D(teta)
    % This function computes a 2D rotation matrix with for the angle teta.

    % Function
    f = @(teta_) [cos(teta_) -sin(teta_); sin(teta_) cos(teta_)];

    % Direct computation
    R = f(teta);
end