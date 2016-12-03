function f = sweep()
    angles = linspace(0.2,2*pi,10);     n1 = length(angles);
    m = linspace(1,10,20);          n2 = length(m);
    f = zeros(n1,n2);
    for i = 1:n1
        for j = 1:n2
%             disp('Target Omega:')
%             disp(angles(i))
%             disp('Mass:')
%             disp(m(j))
            f(i,j) = plotpath(m(j), angles(i));
%             disp('Force:')
%             disp(f(i,j))
        end
    end
    pcolor(m, angles, f)
    shading interp
    colorbar
    xlabel('Mass')
    ylabel('Target angular velocity')
    %plot(m, f);
end