function new_popu = nextpopu(popu, fitness, xover_rate, mut_rate)
new_popu = popu;
popu_s = size(popu, 1);
string_length = size(popu, 2);
fitness = fitness - min(fitness);
team_fitness = fitness;
[junk, index1] = max(team_fitness);
team_fitness(index1) = min(team_fitness);
[junk, index2] = max(team_fitness);
new_popu([1 2], :) = popu([index1 index2], :);

total = sum(fitness);
if total==0
    fitness = ones(popu_s, 1)/popu_s;
end

cum_prob = cumsum(fitness)/total;

for i=2:popu/2
    tmp = find(cum_prob-rand>0);
    parent1 = popu(tmp(1), :);
    tmp = find(cum_prob-rand>0);
    parent2 = popu(tmp(1), :);
    
    if rand<xover_rate
        xover_point = ceil(rand*string_length-1);
        part1 = parent1(1:xover_point);
        part2 = parent2(xover_point+1:string_length);
        new_popu(i*2-1, :) = cross_over(part1, part2);
        
        part1 = parent2(1:xover_point); 
        part2 = parent1(xover_point+1:string_length);
        new_popu(i*2, :) = cross_over(part1, part2, xover_rate);
    end
end

new_popu = mutation(new_popu, mut_rate);
% mask = rand(popu_s, string_length)<mut_rate;
% new_popu = xor(new_popu, mask);
new_popu([1 2], :) = popu([index1 index2], :);

end

function new=cross_over(part1, part2)
for k=1:size(part2,2)
    part1(ismember(part1, part2(k)))=[];
end
part2 = part2(randperm(length(part2)));
new = [part1 part2];
end

function new_popu=mutation(popu, mutate_rate)
r = randi([1 mutate_rate],1,2);
copy_popu = popu;
for i=1:size(popu,1)
    temp = copy_popu(i,r(1):r(2));
    temp = temp(randperm(length(temp)));
    copy_popu(i, r(1):r(2)) = temp;
    popu(i) = copy_popu(i);
end
new_popu = popu;
end