function [alphas]= learn_gaussian(X,Y,B,sigma2)
   [m, ~] = size(X);
   T = 100 * m;
   Z=X*X';
   G = exp(-((repmat(diag(Z)',m,1)-2*Z+repmat(diag(Z),1,m)))/sigma2);
   Alpha = zeros(T, m);
   j = unidrnd(m, [1, T-1]);
   for t=1:T-1
       x = G(j(t), :);
       y = Y(j(t));
       % find subgradient
       if 1 - y * x * Alpha(t, :)' > 0
           g = -y*x;
       else
           g = 0;
       end
       % update
       alpha_t = Alpha(t, :) - (g / sqrt(t));
       %normalize
       norm_aplha = sqrt(alpha_t * G * alpha_t');
       if norm_aplha > B
           alpha_t = B * alpha_t / norm_aplha;
       end
       Alpha(t+1, :) = alpha_t;
   end
   alphas = mean(Alpha)';
end