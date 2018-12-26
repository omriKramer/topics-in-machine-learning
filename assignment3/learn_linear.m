function [w]=learn_linear(X,Y,B)
   [m, d] = size(X);
   T = 100 * m;
   W = zeros(T, d);
   j = unidrnd(m, [1, T-1]);
   for t=1:T-1
       x = X(j(t), :);
       y = Y(j(t));
       % find subgradient
       if 1 - y * x * W(t, :)' > 0
           g = -y*x;
       else
           g = 0;
       end
       %update
       u = W(t, :) - (g / sqrt(t));
       %normalize
       if norm(u) > B
           u = B * u / norm(u);
       end
       W(t+1, :) = u;
   end
   w = mean(W);
end