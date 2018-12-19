load mnist.mat
for B=[1e-5 1 1e5]
   w = learn_linear(Xtrain, Ytrain, B);
   loss = mean(Ytest ~= sign(Xtest * w'));
   disp([B loss])
   imagesc(reshape(w,28,28)'); colormap gray;
end