%   The Viola-Jones constrained face detection algorithm.
%   
%   Input:
%   m - Size of training set.
%   T - Number of rounds.
%   
%   Output:
%   h - (8xT) matrix storing the returned weak learners (see WL.m for further documentation).
%   w - (1xT) vector of weights of the returned weak learners.
%   weakErr - (1xT) vector of the error of the returned weak learner at each iteration.
%   trainingErr - (1xT) vector of the training error of the Strong learner at each iteration.

function [h, w, weakErr, trainingErr] = vjAdaBoost(m, T)
    fprintf('Loading data set...') 
    data = load('vjDataTrain.txt');                                 % load dataset
    y = data(1:m, 1)';                                              % parse it
    X = data(1:m, 2:end);                                           
    y(y==0) = -1;                                                   % adaBoost expects classes +1, -1
    
    D = ones(1, m) / m;
    h = zeros(8, T);
    w = zeros(1, T);
    weakErr = zeros(1, T);
    trainingErr = zeros(1, T);
    predictions = zeros(T, m);
    for t=1:T
        h(:, t) = WL(D, X, y)';
        predictions(t, :) = predict(h(:, t), X);
        weakErr(t) = D * (y ~= predictions(t, :))';
        w(t) = log(1/weakErr(t) - 1) / 2;
        exp_score = D .* exp(-w(t) .* (y .* predictions(t, :)));
        D = exp_score ./ sum(exp_score);
        current_pred = sign(w(1:t) * predictions(1:t, :));
        trainingErr(t) = sum(y ~= current_pred) / m;
    end
    fprintf('       Done.\n')
    save vjRes.mat h w weakErr trainingErr
end

