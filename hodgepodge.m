function [infected] = hodgepodge(siz, n, k_1, k_2, g, t_steps)

% Hodgepodge Machine
% cellular automata of catalytic reactions  
% implemented according to Gerhardt and Schuster (1988)
% 
%
% hodgepodge(siz, n, k_1, k_2, g, t_steps)
%
% siz = 2-tuple with dimensions of automaton grid
% n = number of states for each cell
% k_1 = constant which scales number of local infected states 
% k_2 = constant which scales number of local ill states
% g = infection rate
% t_steps = number of time steps to run for
%
% Most classic automaton that simulates Belousov-Zhabotinsky reaction
% corresponds to the following command:
%
% hodgepodge([200 100], 100, 3, 2, 20, 4000)
%
%
% See original article for automaton rules
% Peter Nekrasov


grid = randi([0,n],siz);
h = pcolor(grid);
set(gca,'Visible','off')
hold on;
h.FaceColor = 'interp';
set(h, 'EdgeColor', 'none');
drawnow();
pause(0.3);
infected = zeros(1, t_steps);

for t = 1:t_steps
    new_grid = zeros(siz);
    infected(t) = sum(0 < grid & grid < n,'all');
    for i = 1:siz(1)
        for j = 1:siz(2)
            idx = [i-1, j; i-1, j+1; i, j+1; i+1, j+1; i+1, j; i+1, j-1; 
                   i, j-1; i-1, j-1];
            idx = mod(idx - 1, siz) + 1;
            idx = sub2ind(siz, idx(:,1), idx(:,2));
            neighbors = grid(idx);
            if grid(i,j) == 0
                n_inf = sum(0 < neighbors & neighbors < n);
                n_ill = sum(neighbors == n);
                new_grid(i,j) = floor(n_inf / k_1) + floor(n_ill / k_2);
            elseif grid(i,j) >= n
                new_grid(i,j) = 0;
            else
                n_inf = sum(0 < neighbors & neighbors < n);
                infecteds = neighbors(0 < neighbors & neighbors < n);
                tot = (sum(infecteds)) / n_inf;
                new_state = floor(tot) + g;
                if new_state >= n
                    new_state = n;
                end
                new_grid(i,j) = new_state;
            end
        end
    end
    grid = new_grid;
    figure(1)
    set(h, 'CData', grid);
    drawnow();
    pause(0.2);
    figure(2);
    title(sprintf('n = %d, k_1 = %d, k_2 = %d, g = %d, t = %d', n, k_1, k_2, g, t))
    ylabel('% Infected')
    xlabel('Time Step')
    plot(1:nnz(infected), infected(1:t) / prod(siz)); 
end