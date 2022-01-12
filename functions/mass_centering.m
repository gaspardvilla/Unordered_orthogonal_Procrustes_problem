function AA = mass_centering(A)
    % The idea for this fucntion is to center the mass centers of A to the 
    % origin 0.
    
    % Get the number nA of points in A
    s = size(A);
    n = s(1);
    
    % Get a vector of size n with all ones
    onesA = ones(n, 1);
    
    % Get the mass center of A
    mass_A = (1 / n) * A' * onesA;
    
    % Centering everything
    AA = A - (onesA * mass_A');
end