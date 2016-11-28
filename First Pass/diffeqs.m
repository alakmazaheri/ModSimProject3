function res = diffeqs(time, input)
    omega = input(2);
    
    %Parameters
    length = 2;  % m
    r = length/2; % m
    F_app = input(3); % N
    F = F_app;
    m = 5; % kg
    width = 0.05; % m
    
    rho = 1.225; % kg/m3 ; air density
    CD = 0.82; %approximate drag coeff for long cyl/rectangle
    A = length*width;
    
    %General Equations
    I = (1/12)*m*length^2; %kg m^2
        
    %Torque Equations
    if(time == 0 || omega < (0.5*1e-05))
        F = F_app;
    else
        F = 0;
    end
    t_app1 = r*F; %kg m
    t_app2 = -r*-F;  %kg m

    drag_force1 = @(x) -0.5*rho*(omega*x).^2*CD*A; 
    t_drag1 = integral(drag_force1, 0, length/2)*1e5;
    
    drag_force2 = @(x) -0.5*rho*(omega*x).^2*CD*A;
    t_drag2 = integral(drag_force2, -length/2, 0)*1e5;
    
    %Net torque
    T = t_app1 + t_app2 + t_drag1 + t_drag2; %N m

    %DIFFEQs
    d_theta_dt = omega;
    d_omega_dt = T/I;
    
    res = [d_theta_dt; d_omega_dt; F];
end

