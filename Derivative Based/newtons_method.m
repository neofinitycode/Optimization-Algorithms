
function newtons_method(x)
    %arguments: x-value of x
    
    syms x1 x2;
    f = (x2-x1)^4 + 12*(x1*x2) - x1 + x2 - 3; %given function
    grad = gradient(f,[x1 x2]); %calculating the gradient with respect to x1 and x2
    %disp(grad);
    hsn = hessian(f,[x1 x2]); %calculating hessian/double derivative with respect to x1 and x2
    x = transpose(x);
    
    
    z1 = -1:0.1:1; %setting up the range for x1 and x2
    z2 = -1:0.1:1;
    [L1,L2] = meshgrid(z1,z2); 
    F = (L2-L1).^4 + (12.*L1.*L2) - L1 + L2 - 3;
    mesh(L1, L2, F); %to plot the 3D graph
    %contour(L1, L2, F, 20); %to plot the projections/local sets of the 3D graph
    pause(8);
    hold on;
    niter = 0;
    dx = inf;
    range = 0.01
    
    while (dx>range)
        gr = subs(grad,{x1, x2},{vpa(x(1),2), vpa(x(2),2)});
        disp('gradient: '); disp(vpa(gr,2));
        hs = subs(hsn,{x1, x2},{x(1), x(2)});
        disp('hessian: '); disp(vpa(hs,2));
        
        result = second_function(x);
        disp('local sets:');disp(vpa(result,2));
        plot3(x(1), x(2), second_function(x), 'ko', 'linewidth', 5);
        pause(0.01);
        x = x - inv(hs)*gr; %identify the newer value of x 
        disp('new values:');disp(vpa(x,2));

        if(vpa(norm(gr),2)<range)
            break
        end
       
        niter=niter+1;
    end  
    %minimum value
    plot3(x(1), x(2), second_function(x), 'ko', 'linewidth', 5);
    pause(0.01);
    disp('number of iterations'); disp(niter);
    disp('minimum value');disp(vpa(x,2)); %
    disp('gradient value');disp(vpa(subs(grad,{x1, x2},{x(1), x(2)}),2));
    disp('local set value');disp(vpa(second_function(x)));
end
    


