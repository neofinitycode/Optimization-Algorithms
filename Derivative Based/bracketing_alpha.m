function [init, final] = bracketing_alpha(alpha, x, g)
    %arguments: alpha-initial alpha value
    %x-initial value of x
    %g-gradients at point x with respect to function f

    disp('In bracketing alpha');
    syms x1 x2 a;
    eps = 0.075; %learning rate for finding the optimal bracket
    f = @(x1,x2) (x2-x1)^4+12*x1*x2-x1+x2-3; %given function 
    y = f(x(1)-a*g(1), x(2)-a*g(2)); %subsitute the alpha within the function
    grad = gradient(y,a); %calculating the gradient with respect to alpha
    gr = subs(grad,{a},{alpha});
    
    %selecting four alpha points to appropriate indetify the bracket
    %containing minimum alpha
    alpha_0 = alpha; 
    alpha_1 = alpha_0 - eps*(gr/vpa(norm(gr),2));
    alpha_2 = alpha_0 - (2*eps)*(gr/vpa(norm(gr),2));
    alpha_3 = alpha_0 - ((2^2)*eps)*(gr/vpa(norm(gr),2));
    
    %values of the function once above four alpha values are substituted
    f_0 = f(x(1)-alpha_0.*g(1), x(2)-alpha_0*g(2));
    f_1 = f(x(1)-alpha_1.*g(1), x(2)-alpha_1*g(2));
    f_2 = f(x(1)-alpha_2.*g(1), x(2)-alpha_2*g(2));
    f_var = f(x(1)-alpha_3.*g(1), x(2)-alpha_3*g(2));
    
    %conditions to decide the optimal bracket
    if f_0<f_1
        %returning the optimal bracket
        init = alpha_0;
        final = alpha_1;
    elseif f_0>f_1 && f_1<f_2
        %returning the optimal bracket
        init = alpha_0;
        final = alpha_2;
    elseif f_0>f_1 && f_1>f_2 && f_2<f_var
        %returning the optimal bracket
        init = alpha_1; 
        final = alpha_3;
    else
        c = 3;
        f_3 = f_2;
        while(f_3>f_var)
            f_3=f_var;
            alpha_4 = alpha_0 - ((2^c)*eps)*(gr/vpa(norm(gr),2));
            c = c+1;
            if mod(c,2)==0
                alpha_2 = alpha_3;
            end
            
            f_var = f(x(1)-alpha_4*g(1), x(2)-alpha_4*g(2));
        end
        %returning the optimal bracket
        init = alpha_2;
        final = alpha_4;
    end
end