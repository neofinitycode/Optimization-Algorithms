function value = second_function(x)
    %arguments: x-value of x
    x1 = x(1);
    x2 = x(2);
    value = (x2-x1)^4 + 12*(x1*x2) - x1 + x2 - 3; %returning the value of the function at x
end