function fibonacci_search(x)
    %arguments: x-value of x

    [init, final] = bracketing(x);
    a = transpose(init);
    b = transpose(final);
    accp_range = 0.01;
    disp(vpa(a,2));
    disp(vpa(b,2));
    
    %disp('uncertainity range');disp(vpa(norm(b-a),2));
    
    %finding the number of iterations for fibonacci search
    %f = [0 1 1 2 3 5 8 13 21 34 55 89 144];
    f = fibonacci(1:20);
    eps = 0.075;
    index=5;
    for i=4:length(f)
        if f(i)>ceil((1+2*eps)*norm(b-a)/accp_range)
            index = i;
            break
        end
    end
    
    index = index+1; %number of iterations = index-4 (initial 3 values of fibonacci ignored)
    
    
    rho = 1-f(index-1)/f(index); %value of rho
    a1 = a+rho.*(b-a);
    b1 = a+(1-rho).*(b-a);
    f_1 = custom_function(a1);
    f_2 = custom_function(b1);
    
    syms z1 z2;
    z1 = -2:0.1:2; %setting up the range for x1 and x2
    z2 = -2:0.1:2;
    [L1,L2] = meshgrid(z1,z2); 
    F = (L1).^2 + L1.*L2 + (L1).^2;
    mesh(L1, L2, F);
    pause(8);
    hold on;
    
    while(and(vpa(norm(b1-a1),2)>accp_range, f(index)~=2))
        plot3(a1(1), a1(2), custom_function(a1), 'r*', 'linewidth', 5);
        plot3(b1(1), b1(2), custom_function(b1), 'ko', 'linewidth', 5);
        
        disp(vpa(a1,2)); disp(vpa(b1,2));
        pause(0.01);
        if f_1<f_2
            b=b1; %updating the value of 'b' by keeping 'a' same
            a1 = a+rho.*(b-a); %similarly update 'a1' and 'b1'
            b1 = a+(1-rho).*(b-a);
            f_1 = custom_function(a1);
            f_2 = custom_function(b1);
        else
            a=a1;
            a1 = a+rho.*(b-a); %updating the value of 'a' by keeping 'b' same
            b1 = a+(1-rho).*(b-a); %similarly update 'a1' and 'b1'
            f_1 = custom_function(a1);
            f_2 = custom_function(b1);
        end  
        index = index - 1;
        rho = 1 - (f(index-1)/f(index));%changing the value of rho once iterations are updated
        
    end
    %local minimum value of function considering the fact that function is unimodal
    disp(vpa(a1,2));
    disp(vpa(b1,2));
end