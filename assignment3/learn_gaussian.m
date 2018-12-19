function [alphas]= learn_gaussian(X,Y,B,sigma2)
   [m, ~] = size(X);
   Z=X*X';
   G = exp(-((repmat(diag(Z)',m,1)-2*Z+repmat(diag(Z),1,m)))/sigma2);
   alphas = learn_linear(G, Y, B);
%    W = zeros(100*m +1, d);
%    j = unidrnd(m, [1, 100*m]);
%    for t=1:100*m
%        x = G(j(t), :);
%        y = Y(j(t));
%        % find the subgradient
%        if y * x' * W(t, :) <= 1
%            g = -y*x;
%        else
%            g = 0;
%        end
%        u = W(t, :) - (g / sqrt(t));
%        if norm(u) > B
%            u = B * u / norm(u);
%        end
%        W(t+1, :) = u;
%    end
%    alphas = mean(W(1:100*m, :));
end