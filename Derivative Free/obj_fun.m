function y=obj_fun(path, distance)
y = 0;
for i=2:size(path,2)
    y=y+distance(cities(i-1), cities(i));
end
end