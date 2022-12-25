function fitness = evalpopu(popu, distance)%, obj_fun)
[popu_s, string_length] = size(popu);
%fitness = zeros(size(popu),1);
for i=1:popu_s
    path = popu(i);
    fitness(i) = vpa(obj_fun(path, distance),2);
end
end