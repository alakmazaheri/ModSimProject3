function netforce = plotpath(m,omega_target)
    close all
    
    %m = 10; % kg
    len = 2;  % m
    r = (len/2)*0.75; % m
    width = 0.05; % m
    
    rho = 1.225; % kg/m3 ; air density
    CD = 0.82; %approximate drag coeff for long cyl/rectangle
    A = len*width;
    
    %General Equations
    I = (1/12)*m*len^2; %kg m^2
    F_push = omega_target*I/(2*r);

    end_time = 600;    
    theta0 = 0;
    omega0 = 0;
    
    d = [theta0; omega0];  
    te = 0;
    
options = odeset('Events', @myEvent);

curr_time = 0;
etimes = [0];
all_times = [0];
all_thetas = [0];
all_omegas = [0];

while (curr_time < end_time)
    end_time = floor(end_time-curr_time);
% %     disp('END TIME:')
% %     disp(end_time)
    [t, Out, te] = ode45(@diffeqs, [0:1:end_time], d, options);
    if(length(te) > 1)
        curr_time = te(2,:);
    else
        curr_time = te;
    end
% %     disp('Te:')
% %     disp(curr_time)
    
    etimes = [etimes; te];

    this_theta = Out(:,1);
    this_omega = Out(:,2);

    all_times = [all_times; t];
    all_thetas = [all_thetas; this_theta];
    all_omegas = [all_omegas; this_omega];
    
    d = [this_theta(end) this_omega(end)];
end

    theta = all_thetas*1e4*0.5;
    omega = all_omegas*1e4*0.5;
    
    %% Animate
%     P1 = [0 0];
%     figure
%     axis(gca, 'equal');
%     axis([-3 3 -3 3])
% 
%         for inc = 1:length(theta)
%             curr_angle = theta(inc);
%             
%             P2 = [cos(curr_angle) sin(curr_angle)];
%             P3 = -1*[cos(curr_angle) sin(curr_angle)];
%             top_half = line([P1(1) P2(1)], [P1(2) P2(2)]);
%             bottom_half = line([P1(1) P3(1)], [P1(2) P3(2)]);
%             pause(0.01);
%             delete(top_half);
%             delete(bottom_half);
%         end     
   %%
    %plot(omega)
    %angle_stuff = [theta omega];
    %time_stuff = all_times;
    netforce = length(etimes)*F_push*2;
    %disp('Inside force:')
    %disp(netforce)
    
    function res = diffeqs(time, input)
        omega1 = input(2,:);

        %Torque Equations
        if(time == 0) %|| (omega < 0.5*1e-05))
            F = F_push;
            %disp('PUSH'); disp(theta)
        else
            F = 0;
        end
        t_app1 = r*F; %kg m
        t_app2 = -r*-F;  %kg m

        drag_force1 = @(x) -0.5*rho*(omega1*x).^2*CD*A; 
        t_drag1 = integral(drag_force1, 0, len/2)*1e5*0.1;

        drag_force2 = @(x) -0.5*rho*(omega1*x).^2*CD*A;
        t_drag2 = integral(drag_force2, -len/2, 0)*1e5*0.1;

        %Net torque
        T = t_app1 + t_app2 + t_drag1 + t_drag2; %N m

        %DIFFEQs
        d_theta_dt = omega1;
        d_omega_dt = T/I;

        %disp(omega1)
        res = [d_theta_dt; d_omega_dt]; 
    end

end

function [value, isterminal, direction] = myEvent(t, omega)
speed_diff = (omega(2,:)*1e5 - 0.5*1e-05)*10 - 10;
%disp('time'); disp(t)
%disp('speed'); disp(speed_diff)
value = speed_diff;
    %position = mod(theta, pi);
    %value = [speed; position];
    
    isterminal = 1;
    direction = 0;
end


