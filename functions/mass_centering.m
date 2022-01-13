function A_centered = mass_centering(A)
    %% Description

    % The idea for this fucntion is to center the mass centers of A to the 
    % origin 0.

    % A: matrix of size n x d that contains all the initial points for our
    % test.


    %% Code
    
    % Get the number n of points
    s = size(A);
    n = s(1);
    
    % Get a vector of size n with all ones
    ones_ = ones(n, 1);
    
    % Get the mass center of A
    mass_A = (1 / n) * A' * ones_;
    
    % Centering everything
    A_centered = A - (ones_ * mass_A');
end