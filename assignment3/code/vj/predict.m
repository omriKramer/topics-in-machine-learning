%   Prediction over a weak learner
%
%   Input:
%   h - A weak learner returned by function WL
%   X - A sample of m 24x24 grayscale images to predict.
%
%   Output:
%   y - the vector of predictions of h over X.

function y = predict(h, X)
    fv = (X * reshape(drawHaar(h(4:8)), 576, 1))';
    y = (2 * (fv > h(3)) - 1) * h(2);
end