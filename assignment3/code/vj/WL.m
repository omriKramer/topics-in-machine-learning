%   Weak Learner
%
%   Input:
%   D - A distribution on a sample S of size m.
%   X - A sample of m 24x24 grayscale images.
%   y - Labelings of X.
%
%   Outputs a weak learner h.
%   h(1) stores the feature index.
%   h(2) stores the sign of the learner.
%   h(3) stores the threshold for which the learner changes its prediction.
%   h(4) stores feature type.
%   h(5)-h(8) store rectangle parameters.

function h = WL(D, X, y)
    h = zeros(1, 8);                                        % initialize h
    features = generateFeatures;                            % get feature list
    fn = size(features, 2);                                 % fn = number of features
    minErr = 2;
    for i = 1:fn                                            % iterate over all features
        if (mod(i, 600) == 1) 
            fprintf('.');                                   % print something so we know it's running
        end       
        fv = (X*reshape(drawHaar(features(:, i)), 576, 1))';% compute feature vector
        [threshold, sgn, err] = weakLearn(fv, y, D);        % retrieve a feature with low error on the data
        if (minErr > err)                                   % a new best WL was found
            minErr = err;
            h(1) = i;
            h(2) = sgn;
            h(3) = threshold;
            h(4:8) = features(:, i)';
        end
    end
    fprintf('\n WL returned feature %d, with weighted error %d\n', h(1), minErr)
end

% returns the optimal threshold and sgn for a given feature
function [threshold, sgn, minErr] = weakLearn(fv, y, D)
    m = size(fv, 2);
    [sfv, I] = sort(fv);
    sy = y(I);
    sD = D(I);
    threshold = sfv(1)-0.5;
    err = sD * (ones(1, m) ~= sy)';
    if (err < 1-err)
        minErr = err;
        sgn = 1;
    else
        minErr = 1-err;
        sgn = -1;
    end
    for i = 1:m-1
        err = err + sy(i)*sD(i);
        if (sfv(i) ~= sfv(i+1))
            if (err < minErr)
                threshold = (sfv(i) + sfv(i+1))/2;
                sgn = 1;
                minErr = err;
            end
            if (1-err < minErr)
                threshold = (sfv(i) + sfv(i+1))/2;
                sgn = -1;
                minErr = 1-err;
            end
        end  
    end
end

% Generate a list of the features (in an indexed form) for Viola-Jones
% Haar filters.
% first row stores type, 4 remaining rows store rectangle parameters.
% assumes 24x24 image sizes.
function F=generateFeatures;
    F=zeros(5, 51300); cnt=1;
    type=1;  % horizontal rectangles
    for h=6:2:24, for w=6:1:24,
      for x=1:24-w+1, for y=1:24-h+1,
        F(:,cnt)=[type,x,y,w,h]';
        cnt=cnt+1;
      end; end;
    end; end;
    type=2;  % vertical rectangles
    for h=6:1:24, for w=6:2:24,
      for x=1:24-w+1, for y=1:24-h+1,
        F(:,cnt)=[type,x,y,w,h]';
        cnt=cnt+1;
      end; end;
    end; end;
    type=3;  % vertical stripes
    for h=6:1:24, for w=6:3:24,
      for x=1:24-w+1, for y=1:24-h+1,
        F(:,cnt)=[type,x,y,w,h]';
        cnt=cnt+1;
      end; end;
    end; end;
    cnt-1;
end
