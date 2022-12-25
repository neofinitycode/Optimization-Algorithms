function num = bit2num(bit, range)
integer = polyval(bit,2);
num = range(1) + integer*(range(2)-range(1))/(2^length(bit)-1);
end