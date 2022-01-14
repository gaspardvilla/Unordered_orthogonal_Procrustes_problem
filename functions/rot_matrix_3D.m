function R = rot_matrix_3D(teta, phi)
    %% Description

    % This function computes a 3D rotation matrix with for the angle teta
    % and phi in spherical coordinates.


    %% Code

    % Function of the 3D rotation matix
    f = @(teta_, phi_) [(sin(teta_) * cos(phi_)) (sin(teta_) * sin(phi)) cos(teta_); 
        (cos(teta_) * cos(phi_)) (cos(teta_) * sin(phi_)) -sin(phi_);
        -sin(phi_) cos(phi) 0];

    % Direct computation
    R = f(teta, phi);
end