%The length of the rod (m)
L = 2;
r = L/2;

%Point P1
P1 = [0 0];

%Parameters of the plot
axis(gca, 'equal');
axis([-3 3 -3 3]);

%The angular speed in rad/s
w = 0.1;

for t = 1:10000
    theta = w*(t/10);
    
    P2 = r*[cos(theta) sin(theta)];
    P3 = -r*[cos(theta) sin(theta)];
    top_half = line([P1(1) P2(1)], [P1(2) P2(2)]);
    bottom_half = line([P1(1) P3(1)], [P1(2) P3(2)])
    pause(0.001);
    delete(top_half);
    delete(bottom_half);

end