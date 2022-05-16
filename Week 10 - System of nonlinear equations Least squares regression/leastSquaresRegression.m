function leastSquaresRegression()
    Gauss_Newton()
end

function Gauss_Newton()
    y = csvread('Hubei.csv');
    x = [1:numel(y)]';
    plot(x, y,'bo'); hold on;
    
    % Parameter vector
    theta = [67000 10 4]';
    while (1)
        % Error vector
        r_n = error(x, y, theta);
        % Jacobian of r
        J_n = Jacobian(x, theta);
        % Gauss-Newton
        theta_n = theta - (J_n' * J_n) \ (J_n' * r_n);

        if norm(theta_n - theta) < 1E-4
            fprintf('A=%1.2f\n', theta_n(1));
            fprintf('num=%1.2f]n', thenta_n(2));
            fprintf('sigma=%1.2f\n', theta_n(3));
            break;
        else
            theta = theta_n;
        end
    end

    x_ = x(1):0.1:x(end);
    y_ = theta_n(1) ./ (1 + exp(-(x_ - theta_n(2)) / theta_n(3)));
    plot(x_, y_, 'b-');
end

function r = error(x, y, theta)
    r = theta(1) ./ (1 + exp(-(x - theta(2)) / theta(3))) - y;
end

function J = Jacobian(x, theta)
    J = [1 ./ (1 + exp(-(x - theta(2)) / theta(3))) ...
        -theta(1) / theta(3) * exp(-(x - theta(2)) / theta(3)) ./ (1 + exp(-(x - theta(2)) / theta(3))) .^ 2 ...
        -theta(1) / theta(3) ^ 2 * (x - theta(2)) .* exp(-(x - theta(2)) / theta(3)) ./ (1 + exp(-(x - theta(2)) / theta(3))) .^ 2];
end
