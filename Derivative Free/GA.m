
function GA()
generation_n = 50; 

cities = 4;
distance = [0 1 3 1; 1 0 2 3; 3 2 0 2; 1 3 2 0];

population = 10;
popu = randperm(cities);
%Create population
for i=1:population
    temp = randperm(cities);
    popu = [popu;temp];
end

xover_rate = 0.75;
mutate_rate = 2;

disp('Population');
disp(popu);

% lower = zeros(generation_n, 1);
% upper = zeros(generation_n, 1);
% average = zeros(generation_n, 1);

for i=1:generation_n
    fun_value = evalpopu(popu, distance);%, obj_fun);
    
    lower(i) = min(fun_value);
    upper(i) = max(fun_value);
    average(i) = mean(fun_value);
    
    plot(i, lower(i), 'color', 'r', 'marker', '*');
    hold on;
    plot(i, upper(i), 'color', 'g', 'marker', '*');
    hold on;
    plot(i, average(i), 'color', 'b', 'marker', '*');
    pause(0.01);
    
    popu = nextpopu(popu, fun_value, xover_rate, mutate_rate);
end

[popu_s, string_length] = size(popu);
disp('Best Possible path: ', popu(1,:))

end