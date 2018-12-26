load mnist.mat
B=1;
w = learn_linear(Xtrain, Ytrain, B);

loss = mean(Ytest ~= sign(Xtest * w'));
imagesc(reshape(w,28,28)');
colormap gray;