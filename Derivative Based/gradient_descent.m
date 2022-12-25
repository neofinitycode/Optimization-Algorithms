function optimal_point = gradient_descent(x, alpha)
    %arguments: x-value of x
    %alpha-constant step size

    syms x1 x2;
    f = @(x1,x2) (x2-x1)^4+12*x1*x2-x1+x2-3; %given function
    
    z1 = -1:0.1:1; %setting up the range for x1 and x2
    z2 = -1:0.1:1;
    [L1,L2] = meshgrid(z1,z2); 
    F = (L2-L1).^4 + (12.*L1.*L2) - L1 + L2 - 3;
    mesh(L1, L2, F); %to plot the 3D graph
    %contour(L1, L2, F, 20); %to plot the projections/local sets of the 3D graph
    pause(8);
    hold on;
    
    grad = gradient(f,[x1 x2]); %calculating the gradient with respect to x1 and x2
    gr = subs(grad,{x1, x2},{vpa(x(1),2), vpa(x(2),2)});
    
    range = 0.01; %uncertainity range decided through experiments
    dx = inf;
    x = transpose(x);
    niter = 0; %iterations decided through experiments
    
    while(and(norm(gr)>range, dx>range))%and(niter>1, dx>range)))
        %disp('gradient: '); disp(vpa(gr,2));
        %result = second_function(x);
        %disp('local sets:');disp(vpa(result,6));
        %disp('new values:');disp(vpa(x,2));
        
        x_new(1) = x(1) - alpha*(gr(1)); %identify the newer value of x
        x_new(2) = x(2) - alpha*(gr(2));
        gr = subs(grad,{x1, x2},{vpa(x_new(1),2), vpa(x_new(2),2)});
        %dx = norm(x_new-x); %euclidean distance between previous and new x values
        plot3(x(1), x(2), second_function(x), 'ko', 'linewidth', 5); %plotting the points
        pause(0.01);
        x = vpa(x_new,2);
        niter = niter+1;
        %disp(vpa(x,2));
    end  
    %minimum value
    plot3(x(1), x(2), second_function(vpa(x,2)), 'ko', 'linewidth', 5);
    pause(0.01);
    optimal_point = vpa(x,2);
    disp('number of iterations'); disp(niter);
    disp('minimum value');disp(vpa(x,2)); %
    disp('gradient value');disp(vpa(subs(grad,{x1, x2},{x(1), x(2)}),2));
    disp('local set value');disp(vpa(second_function(x)));
    
    
end
    


