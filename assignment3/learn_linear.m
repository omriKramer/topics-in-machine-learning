function [w]=learn_linear(X,Y,B)
   [m, d] = size(X);
   W = zeros(100*m +1, d);
   j = unidrnd(m, [1, 100*m]);
   for t=1:100*m
       x = X(j(t), :);
       y = Y(j(t));
       % find subgradient
       if y * x' * W(t, :) <= 1
           g = -y*x;
       else
           g = 0;
       end
       u = W(t, :) - (g / sqrt(t));
       if norm(u) > B
           u = B * u / norm(u);
       end
       W(t+1, :) = u;
   end
   w = mean(W(1:100*m, :));
end