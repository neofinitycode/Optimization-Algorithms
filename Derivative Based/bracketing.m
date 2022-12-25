function [init, final] = bracketing(x)
    %x-initial value of x
    syms x1 x2;
    eps = 0.075; %learning rate for finding the optimal bracket
    x_0 = transpose(x);
    f = (x1)^2 + x1*x2 + (x2)^2; %given function 
    grad = gradient(f,[x1 x2]); %subsitute the alpha within the function
    gr = subs(grad,{x1, x2},{x(1), x(2)}); %calculating the gradient with respect to alpha
    
    %selecting three x points to appropriately identify the bracket
    x_1 = x_0 - eps.*(gr/vpa(norm(gr),2));
    x_2 = x_0 - (2*eps).*(gr/vpa(norm(gr),2));
    x_3 = x_0 - ((2^2)*eps).*(gr/vpa(norm(gr),2));
    
    %values of the function once above four alpha values are substituted
    f_0 = custom_function(x_0);
    f_1 = custom_function(x_1);
    f_2 = custom_function(x_2);
    f_var = custom_function(x_3);
    
    %conditions to decide the optimal bracket
    if f_0<f_1
        %returning the optimal bracket
        init = x_0;
        final = x_1;
    elseif f_0>f_1 && f_1<f_2
        %returning the optimal bracket
        init = x_0;
        final = x_2;
    elseif f_0>f_1 && f_1>f_2 && f_2<f_var
        %returning the optimal bracket
        init = x_1; 
        final = x_3;
    else
        c = 3;
        f_3 = f_2;
        while(f_3>f_var)
            f_3=f_var;
            x_4 = x_0 - ((2^c)*eps).*(gr);
            c = c+1;
            if mod(c,2)==0
                x_2 = x_3;
            end
            
            f_var = custom_function(x_4);
        end
        %returning the optimal bracket
        init = x_2;
        final = x_4;
        
    end
end

