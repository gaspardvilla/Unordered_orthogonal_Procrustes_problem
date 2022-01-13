function visualization_2_sets(A, B, X1, options)

    %% Initialization

    % Initialization of the figure
    figure();
    s = size(A);
    n = s(1);


    %% Plots the sets A and B 

    % Plots of the sets A
    x_A = A(:, 1);
    y_A = A(:, 2);
    ylim([-1.5 1.5]);
    xlabel('x');
    ylabel('y');
    title('Optimal transport found between the sets A and B.')
    set(gca,'color', [0.9 0.9 0.9]);
    hold on;
    ha = plot(x_A, y_A, 'x', 'DisplayName', 'A', 'linewidth', 1.5);
    grid on;

    % Plots of the sets B
    x_B = B(:, 1);
    y_B = B(:, 2);
    hb = plot(x_B, y_B, 'o', 'DisplayName', 'B', 'linewidth', 1.5);



    %% Plot the optimal transport

    % Get the true optimal transport
    X1_ = zeros(n, n);
    for i = 1 : n
        [~, j] = max(X1(i, :));
        X1_(i, j) = 1;
    end

    % Look on how is the optimal transport X1
    for i = 1 : n
        for j = 1 : n
            if (X1_(i,j) == options.X_true(i,j)) && (X1_(i,j) == 1)
                vect = [A(i,:); B(j,:)];
                x = vect(:, 1);
                y = vect(:, 2);
                color = [0.1 0.5 0.1];
                plot(x, y, '-', 'Color', color);
            elseif (X1_(i,j) == 1)
                vect = [A(i,:); B(j,:)];
                x = vect(:, 1);
                y = vect(:, 2);
                color = [0.5 0.1 0.1];
                plot(x, y, '-', 'Color', color);
            end
        end
    end

    % Plot the concentric circles
%     for i = 1 : n
%         c = circle(0, 0, norm(A(i,:)));
%     end

    % Finish the plots
    hold off
    legend([ha hb],{'set A','set B'});
end

% function h = circle(x,y,r)
%     th = 0:pi/50:2*pi;
%     xunit = r * cos(th) + x;
%     yunit = r * sin(th) + y;
%     h = plot(xunit, yunit, 'Color', [0.5,0.5,0.5]);
% end