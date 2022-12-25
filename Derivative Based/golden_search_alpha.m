function s = golden_search_alpha(a0, a1, x, g)
    %arguments: a0-one end of range
    %a1-other end of the same range
    %x-value of x
    %g-gradient at value x
    
    rho = 0.382;    
    a = a0;
    b = a1;
    t = a+(1-rho).*(b-a);
    s = a+rho.*(b-a);
    niter = 1;
    f_1 = alpha_function(x, s, g);
    f_2 = alpha_function(x, t, g);
    disp('In the golden_search method');
    %disp(vpa(norm(s-t),2));
    while(norm(s-t)>0.01)
        if f_1<f_2
            b=t;
            t=s;
            s=a+rho.*(b-a);
            f_2 = f_1;
            f_1 = alpha_function(x, s, g);
        else
            a=s;
            s=t;
            t=a+(1-rho).*(b-a);
            f_1 = f_2;
            f_2 = alpha_function(x, t, g);
        end    
        niter=niter - 1;
    end
end