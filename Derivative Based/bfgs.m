
function optimal_point = bfgs(x, alpha)
    %arguments: alpha-initial alpha value
    %x-initial value of x
    
    z1 = -1:0.1:1; %setting up the range for x1 and x2
    z2 = -1:0.1:1;
    [L1,L2] = meshgrid(z1,z2); 
    F = (L2-L1).^4 + (12.*L1.*L2) - L1 + L2 - 3;
    %mesh(L1, L2, F); %to plot the 3D graph
    contour(L1, L2, F, 20); %to plot the projections/local sets of the 3D graph
    pause(8);
    hold on;
    
    syms x1 x2;
    f = (x2-x1)^4 + 12*(x1*x2) - x1 + x2 - 3; %given function 
    grad = gradient(f,[x1 x2]); %calculating the gradient with respect to x1 and x2
    gr = subs(grad,{x1, x2},{vpa(x(1),2), vpa(x(2),2)}); 
    disp(gr);
    x=transpose(x);
    
    H = eye(2);
    
    x_range = 0.0001; %uncertainity range decided by multiple experiments
    dx = inf;
    f_val = subs(f,{x1, x2},{vpa(x(1),2), vpa(x(2),2)});
    f_prev = inf;
    gradient_range = power(10,-4);
    
    while(and(vpa(norm(gr),2)>gradient_range, dx>x_range))%and(niter>0, dx>range))
        direction = (-1).*(H*gr);
        [init, final] = bracketing_alpha(alpha, x, direction); %get the brackets for alpha
        alpha = init;
        alpha1 = final;
        alpha = golden_search_alpha(vpa(alpha,2), vpa(alpha1,2), vpa(x,2), vpa(direction,2)); %applying golden_search over alpha
        
        x_new = x + alpha.*direction; %identify the newer value of x
        gr_new = subs(grad,{x1, x2},{vpa(x_new(1),2), vpa(x_new(2),2)});
        
        f_prev = vpa(f_val,2);
        f_val = vpa(subs(f,{x1, x2},{vpa(x_new(1),2), vpa(x_new(2),2)}),2);

        %plot3(x(1), x(2), f_prev, 'r*', 'linewidth', 5);
        plot([x(1) x_new(1)],[x(2) x_new(2)],'r-*');
        pause(0.01);
        
        
        delta_x = x_new-x;
        delta_gr = gr_new - gr;

        H = H+(1+((transpose(delta_gr)*H*delta_gr)/(transpose(delta_gr)*delta_x)))*((delta_x*transpose(delta_x))/(transpose(delta_gr)*delta_x))-(((H*delta_gr*transpose(delta_x))+transpose(H*delta_gr*transpose(delta_x)))/(transpose(delta_gr)*delta_x));
        
        dx = norm(x_new - x); %euclidean distance between previous and new x values
        gr = gr_new;
        x = x_new;
        
        disp('alpha value');disp(vpa(alpha,2));
        
        disp('minimum value');disp(vpa(x,2));
        disp('level set values');disp(vpa(subs(f,{x1, x2},{vpa(x(1),2), vpa(x(2),2)}),2));
        disp('gradient value');disp(vpa(gr,2));
        disp('hessian values');disp(vpa(H,2));
    end
    optimal_point = vpa(x,2);
end
    


