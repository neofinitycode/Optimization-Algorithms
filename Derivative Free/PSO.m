function PSO()
    %arguments: alpha-initial alpha value
    %x-initial value of x
    z1 = -1:0.1:2; %setting up the range for x1 and x2
    z2 = -1.2:0.1:1;
%     [L1,L2] = meshgrid(z1,z2); 
%     F = (L2-L1).^4 + (12.*L1.*L2) - L1 + L2 - 3;
%     mesh(L1, L2, F); %to plot the 3D graph
%     contour(L1, L2, F, 20); %to plot the projections/local sets of the 3D graph
%     pause(8);
%     hold on;
    
    syms x1 x2;
    f = (x2-x1)^4 + 12*(x1*x2) - x1 + x2 - 3; %given function 
    
    max_iter = 50;
    n_iter = 50;
    npopu = 10;
    no_dimension = 2;
    
    positions = zeros(npopu,no_dimension);
    velocities = zeros(npopu,no_dimension);
    %initializing the population
    for c=1:npopu 
            a = -1;
            b = 1;
            rx = (b-a).*rand(1,1) + a;
            ry = (b-a).*rand(1,1) + a;
            positions(c,1) = rx;
            positions(c,2) = ry;
            
            vx = (b-a).*rand(1,1) + a;
            vy = (b-a).*rand(1,1) + a;
            velocities(c,1) = vx;
            velocities(c,2) = vy;
    end
    

    %first iteration
    personal_best = positions;%copy(positions);
    global_best_position = positions(1,:);
    global_best_level_set = vpa(subs(f,{x1, x2},{vpa(positions(1,1),2), vpa(positions(1,2),2)}),2);
    for c=2:npopu
        temp = vpa(subs(f,{x1, x2},{vpa(positions(c,1),2), vpa(positions(c,2),2)}),2);
        if global_best_level_set>temp
            global_best_level_set = temp;
            global_best_position = positions(c,:);
        end
    end
    
    prev = -inf;
    %K-steps
    range_global_best = 0.01;%uncertainity range decided by multiple experiments
    xx = 0;
    %constants
    c1 = 2.1; %cognitive_coefficient
    c2 = 2.1; %social_coefficient
    w = 0.9; %initial weight
    K = 0.729; %Constriction factor
    
    best_cost = zeros(n_iter,1);
    
    figure;
    
    while(n_iter>0)%(vpa(norm(global_best_level_set,prev),2)>range_global_best)%
        prev = global_best_level_set;
        %generating n-vectors r(k) and s(k)
        r = zeros(1,no_dimension);
        s = zeros(1,no_dimension);

        fun_values = zeros(npopu,1);
        for c=1:npopu
            fun_values(c) = vpa(subs(f,{x1, x2},{vpa(positions(c,1),2), vpa(positions(c,2),2)}),2);
        end
        
        minimum = min(fun_values);
        maximum = max(fun_values);
        average = mean(fun_values);
        if maximum<0
            maximum = -1*mod(abs(maximum),20);
        else
            maximum = mod(abs(maximum),20);
        end
        if average<0
            average = -1*mod(abs(average),20);
        else
            average = mod(abs(average),20);
        end
        
        disp('minimum');disp(minimum);
        disp('average');disp(average);
        disp('maximum');disp(maximum);
        plot(xx, minimum, 'color', 'g', 'marker', '*');
        hold on;
        plot(max_iter-n_iter, maximum, 'color', 'r', 'marker', '*');
        hold on;
        plot(max_iter-n_iter, average, 'color', 'b', 'marker', '*');
        pause(0.01);
        
%         C = jet(npopu);
%         for i=1:npopu
%             plot(personal_best(i,1), personal_best(i,2), 'color', C(i,:), 'marker', 'o');
%             pause(0.001);
%             %plot([positions(i,1) positions(c,2)],[x(2) x_new(2)],'r-*');
%         end
        
        
        
        %updating the positions using their respective velocities
        for c=1:npopu 
            %positions(c,1) = rx;
            %positions(c,2) = ry;
            for z=1:npopu 
                a = 0;
                b = 1;
                rx = (b-a).*rand(1,1) + a;
                ry = (b-a).*rand(1,1) + a;
                r(1) = rx;
                r(2) = ry;

                sx = (b-a).*rand(1,1) + a;
                sy = (b-a).*rand(1,1) + a;
                s(1) = sx;
                s(2) = sy;
            end
         
            velocities(c,:) = w*velocities(c,:)+c1*(r.*(personal_best(c,:)-positions(c,:)))+c2*(s.*(global_best_position(1,:)-positions(c,:)));
            positions(c,:) = positions(c,:)+K*velocities(c,:); 
        end
        %disp('new velocity');disp(velocities);
        
        
        %updating the personal best
        for c=1:npopu 
            next_personal_best = vpa(subs(f,{x1, x2},{vpa(positions(c,1),2), vpa(positions(c,2),2)}),2);
            prev_personal_best = vpa(subs(f,{x1, x2},{vpa(personal_best(c,1),2), vpa(personal_best(c,2),2)}),2);
            
            if next_personal_best < prev_personal_best
                personal_best(c, :) = positions(c, :);
            %else
                %do nothing previous personal best to carry forward
            end
        end
        
        
        %updating the global best
        for c=1:npopu 
            next_global_best = vpa(subs(f,{x1, x2},{vpa(positions(c,1),2), vpa(positions(c,2),2)}),2);
            prev_global_best = vpa(subs(f,{x1, x2},{vpa(global_best_position(1,1),2), vpa(global_best_position(1,2),2)}),2);
            
            if next_global_best < prev_global_best
                global_best_position = positions(c,:);
                global_best_level_set = vpa(subs(f,{x1, x2},{vpa(positions(c,1),2), vpa(positions(c,2),2)}),2);
            %else
                %do nothing previous global best to carry forward
            end
        end
 
        n_iter = n_iter-1;
        best_cost(50-n_iter+1) = global_best_level_set;
        
        
        
        
        %disp('Iterations');disp(n_iter);
        %disp('positions');disp(positions);
        %disp('new positions');disp(positions);
       
        
        w = w-0.01;
        xx=xx+1;
        
    end
    %disp('personal best');disp(personal_best);
    %disp('global_best_level_set');disp(global_best_level_set);
    
    figure;
    plot(best_cost, 'LineWidth', 3);
    xlabel('Iterations');
    ylabel('Cost');
    
    %optimal_point = vpa(x,2);
end
    


