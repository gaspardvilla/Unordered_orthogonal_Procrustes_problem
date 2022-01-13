function visualization_orth_transf(A, B, C, options, method_name)
    %% Description

    % The idea of this function is to make a visualization of the two
    % initial set of points A and B with the final transformation of the
    % set B by the matrix Q_sol we found with previous metod. It is very
    % usefull to check the accuracy of the orthgonal transformations.


    %% Code

    % Check if the initialization of A and B is custom or random
    if ~strcmp(options.custom, 'waves') && ~strcmp(options.custom, 'spirale')
        custom = false;
    else 
        custom = true;
    end

    % Initialization of the figure
    figure();
    
    % Is we have customized data set
    if custom
        if strcmp(options.custom, 'waves')
            xlim([-4, 4]);
            ylim([-1.5, 1.5]);
        else
            maxx = 1.25;
            axis([-1 1 -1 1] * maxx);
        end
        hold on;
        
        % Plots of the sets B
        x_B = B(:, 1);
        y_B = B(:, 2);
        hb = plot(x_B, y_B, 'o', 'DisplayName', 'B', 'linewidth', 1);
    
        xlabel('x');
        ylabel('y');
        title({['Visualization of the solutions regarding the target and the ' ...
                'starting set '], ['with the ', method_name]});
        set(gca,'color', [0.9 0.9 0.9]);
        grid on;
    
        % Plots of the sets A
        x_A = A(:, 1);
        y_A = A(:, 2);
        ha = plot(x_A, y_A, 'x', 'DisplayName', 'A', 'linewidth', 1);
        
        % Plots of the sets C
        x_C = C(:, 1);
        y_C = C(:, 2);
        hc = plot(x_C, y_C, 's', 'DisplayName', 'B * Q_{sol}', 'linewidth', 1,'MarkerEdgeColor', '#77AC30');

        hold off
        legend([ha hb hc], {'set A', 'set B', 'set B * Q_{sol}'});

    % If we have random data set
    else
        % Sort the data sets into clowise order
        A = clock_sort(A);
        B = clock_sort(B);
        C = clock_sort(C);
        
        hold on

        % Plots of the sets B
        x_B = B(:, 1);
        y_B = B(:, 2);
        hb = plot(x_B, y_B, 'o', 'DisplayName', 'B', 'linewidth', 1);
    
        xlabel('x');
        ylabel('y');
        title({['Visualization of the solutions regarding the target and the ' ...
                'starting set '], ['with the ', method_name]});
        set(gca,'color', [0.9 0.9 0.9]);
        grid on;
    
        % Plots of the sets A
        x_A = A(:, 1);
        y_A = A(:, 2);
        ha = plot(x_A, y_A, 'x', 'DisplayName', 'A', 'linewidth', 1);
        
        % Plots of the sets C
        x_C = C(:, 1);
        y_C = C(:, 2);
        hc = plot(x_C, y_C, 's', 'DisplayName', 'B * Q_{sol}', 'linewidth', 1,'MarkerEdgeColor', '#77AC30');

        % Concentric circles
        if ~custom
            for idx = 1 : options.n
                circle(0, 0, norm(A(idx, :)));
            end
        end

        fa = fill(A(:,1), A(:,2), [0.8500 0.3250 0.0980]);
        fb = fill(B(:,1), B(:,2), [0 0.4470 0.7410]);
        fc = fill(C(:,1), C(:,2), [0.4660 0.6740 0.1880]);

        hold off
        alpha(fa, 0.2)
        alpha(fb, 0.2)
        alpha(fc, 0.2)
        legend([ha hb hc fa fb fc], {'set A', 'set B', 'set B * Q_{sol}', 'set A', 'set B', 'set B * Q_{sol}'});

    end

end

function h = circle(x,y,r)
    th = 0:pi/50:2*pi;
    xunit = r * cos(th) + x;
    yunit = r * sin(th) + y;
    h = plot(xunit, yunit, 'Color', [0.5,0.5,0.5]);
end