load gaussian_data.mat
alphas = learn_gaussian(X, Y, 100, 2);
show_gaussian(X,Y,alphas',2);