function res = diffeqs(~, input)
    theta = input(1);
    omega = input(2);
    
    length = 2;   % m
    r = length/2; % m
    F = 2; % N
    m = 5; % kg
    
    %General Equations
    I = (1/12)*m*length^2;

    %Torque Equations
    tau1 = r*F;
    tau2 = -r*-F;
    T = tau1 + tau2;

    %DIFFEQs
    d_theta_dt = omega;
    d_omega_dt = T/I;
    
    res = [d_theta_dt; d_omega_dt];
end

