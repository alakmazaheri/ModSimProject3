function res = plotpath(F_app)
    final_time = 30;    
    theta0 = 0;
    omega0 = 0;
    d = [theta0; omega0];
    
    [t,Out] = ode45(@diffeqs, [0 final_time], d);
    
    theta = Out(:,1);
    omega = Out(:,2);
    P1 = [0 0];
    
    figure
    axis(gca, 'equal');
    axis([-3 3 -3 3]);

    for t = 1:10
        for inc = 1:length(theta)
            curr_angle = theta(inc);

            P2 = [cos(curr_angle) sin(curr_angle)];
            P3 = -1*[cos(curr_angle) sin(curr_angle)];
            top_half = line([P1(1) P2(1)], [P1(2) P2(2)]);
            bottom_half = line([P1(1) P3(1)], [P1(2) P3(2)])
            pause(0.01);
            delete(top_half);
            delete(bottom_half);
        end
    end
    res = Out;
end

