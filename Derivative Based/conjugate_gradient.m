function optimal_point = conjugate_gradient(x)
    %arguments: x-value of x
    %alpha-constant step size
    x = transpose(x);
    syms x1 x2;
    f = @(x1,x2) (x1)^2+(x2)^2+x1*x2-3*x1; %given function
    Q = [2 1;1 2];
    b = [3 0];
    
    z1 = -1:0.1:1; %setting up the range for x1 and x2
    z2 = -1:0.1:1;
    [L1,L2] = meshgrid(z1,z2); 
    F = (L1).^2 + (L2).^2 + (L1.*L2) - 3.*L1;
    mesh(L1, L2, F); %to plot the 3D graph
    %contour(L1, L2, F, 20); %to plot the projections/local sets of the 3D graph
    pause(8);
    hold on;
  
    %calculating the gradient with respect to x1 and x2
    gr = Q*x-transpose(b);
    
    dx = inf;
    x_range = 0.001;%uncertainity range decided by multiple experiments
    
    direction = (-1).*gr;
    while(dx>x_range)
        alpha = -((transpose(direction)*gr)/(transpose(direction)*Q*direction));
        x_new(1) = x(1) + alpha*(direction(1)); %identify the newer value of x
        x_new(2) = x(2) + alpha*(direction(2));

        dx = norm(x_new - x); %euclidean distance between previous and new x values
        
        func_value = subs(f,{x1, x2},{vpa(x(1),2), vpa(x(2),2)});
        
        plot3(x(1), x(2), func_value, '-o', 'Color', 'r', 'linewidth', 2); %plotting the points
        %plot([x(1) x_new(1)],[x(2) x_new(2)],'ko-');
        pause(0.01);
        
        x = transpose(vpa(x_new,2));
        gr = Q*x-transpose(b);
        
        if (gr==0)
            plot3(x(1), x(2), func_value, '-o', 'Color', 'r', 'linewidth', 2); %plotting the points
            break;
        else
            beta = ((transpose(gr)*Q*direction)/(transpose(direction)*Q*direction));
            direction = (-1).*gr+(beta.*direction);
        end
        niter = niter-1;
        
        disp('minimum value');disp(vpa(x,2));
        disp('gradient value');disp(vpa(gr,2));
        disp('level set values');disp(vpa(subs(f,{x1, x2},{vpa(x(1),2), vpa(x(2),2)}),2));
        
    end  
    optimal_point = vpa(x,2);
end
    


