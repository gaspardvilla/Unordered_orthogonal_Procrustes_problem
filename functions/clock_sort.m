function A = clock_sort(A)
    %% Description

    % The idea of this function is to sort the points in the matrix A in
    % the clock-wise order. (For visualization only)


    %% Code

    % Initialization
    x = A(:,1);
    y = A(:,2);

    % Mean of the vertices
    cx = mean(x);
    cy = mean(y);

    % Find the angles
    a = atan2(y - cy, x - cx);

    % Sort the angles
    [~, order] = sort(a);

    % Sort the matrix
    A(:,1) = x(order);
    A(:,2) = y(order);
end