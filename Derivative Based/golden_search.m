function golden_search(x)
    %arguments: x-value of x
  
    rho = 0.382; %rho is constant
    %a = x;
    [init, final] = bracketing(x);
    a = transpose(init);
    b = transpose(final);
    
    disp('Bracketing Output:');
    disp(vpa(a,2));
    disp(vpa(b,2));
    
    t = a+(1-rho).*(b-a);
    s = a+rho.*(b-a);
    f_1 = custom_function(s);
    f_2 = custom_function(t);
    
    disp(vpa(s,2));disp(vpa(t,2));
    
    syms x1 x2;
    f = @(x1,x2) x1^2+x1*x2+x2^2;
    %fsurf(f, [-1 1 -1 1]);
    %pause(8);
    %hold on;
    
    z1 = -2:0.1:2; %setting up the range for x1 and x2
    z2 = -2:0.1:2;
    [L1,L2] = meshgrid(z1,z2); 
    F = (L1).^2 + L1.*L2 + (L1).^2;
    mesh(L1, L2, F);
    pause(8);
    hold on;
    
    disp('In the golden_search method');
    
    niter = 9;
    while(vpa(norm(s-t),2)>0.01) %iterating over the uncertainity range of 0.01 between 's' and 't'
        plot3(s(1), s(2), custom_function(s), 'r*', 'linewidth', 5);
        plot3(t(1), t(2), custom_function(t), 'ko', 'linewidth', 5); %plotting the points
        disp(vpa(s,2)); disp(vpa(t,2));
        pause(0.01);
        if f_1<f_2
            b=t; %updating the value of 'b' by keeping 'a' same
            t=s; %similarly update 's' and 't'
            s=a+rho.*(b-a);
            f_2 = f_1;
            f_1 = custom_function(s);
        else
            a=s; %updating the value of 'a' by keeping 'b' same
            s=t; %similarly update 'a1' and 'b1'
            t=a+(1-rho).*(b-a);
            f_1 = f_2;
            f_2 = custom_function(t);
        end    
        niter=niter - 1;
        
        %disp('Uncertainity range');
        %disp(vpa(s,2));
        %disp(vpa(t,2));
    end
    %local minimum value of function considering the fact that function is
    %unimodal
    disp(vpa(s,2));
    disp(vpa(t,2));
end