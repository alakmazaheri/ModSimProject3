function res = plotpath(F_app)
    close all
    final_time = 10*60;    
    theta0 = 0;
    omega0 = 0;
    d = [theta0; omega0; F_app];
    
    [t,Out] = ode45(@diffeqs, [0:1:final_time], d);
    
    theta = Out(:,1)*1e4;
    disp(length(theta))
    omega = Out(:,2)*1e4;
    T = Out(:,3);
    P1 = [0 0];
    
    figure
    axis(gca, 'equal');
    xlim([0 final_time]);
    axis([-3 3 -3 3])

        for inc = 1:length(theta)
            curr_angle = theta(inc);
            %curr_angle = t/10;
            
            P2 = [cos(curr_angle) sin(curr_angle)];
            P3 = -1*[cos(curr_angle) sin(curr_angle)];
            top_half = line([P1(1) P2(1)], [P1(2) P2(2)]);
            bottom_half = line([P1(1) P3(1)], [P1(2) P3(2)]);
            pause(0.01);
            delete(top_half);
            delete(bottom_half);
            %log(t) = curr_angle;
        end
   
    plot(t, omega)
    res = omega;
end

