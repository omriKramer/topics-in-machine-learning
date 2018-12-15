%   The Viola-Jones constrained face detection algorithm.
%   
%   Input:
%   m - Size of training set.
%   T - Number of rounds.
%   
%   Output:
%   h - (8xT) matrix storing the weak learners (see WL.m file for further documentation).
%   w - (1xT) vector of the weights returned by AdaBoost at each iteraion.
%   weakErr - (1xT) vector of the error of the weak learner at each iteration.
%   trainingErr - (1xT) vector of the error of the strong  learner at each iteration.

function [h, w, weakErr, trainingErr] = vjAdaBoost(m, T)
    fprintf('Loading data set...') 
    data = load('vjDataTrain.txt');                                 % load dataset
    y = data(1:m, 1)';                                              % parse it
    X = data(1:m, 2:end);                                           
    y(y==0) = -1;                                                   % adaBoost expects classes +1, -1
    fprintf('       Done.\n') 
    
    
    
    
    
    save vjRes.mat h w weakErr trainingErr
end

