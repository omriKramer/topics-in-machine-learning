%   Shows the first 5 selected features from h on the input image
%   
%   Input:
%   h - (8xT) weak learner matrix where T>=5.
%   x - (1x576) vector storing the grayscale levels of an 24x24 image

function showFeatures(h, x)
    figure(1); 
    for i=1:6, subplot(2,3,i);
        if (i==1)
            imshow(uint8(reshape((x),24,24)));
        else
            imshow(showSingleFeature(h(:,i-1), x));
        end
        colormap(gray); 
    end
end

function im = showSingleFeature(f, instance)
    f = f(4:8);
    if (size(f,2)~=1) error('Only draws one filter.'); end;
    instance = reshape(instance, 24, 24);
    x=f(2,:); y=f(3,:); w=f(4,:); h=f(5,:); htype=f(1,:);
    switch htype
        case 1, instance(y:y+h/2-1,x:x+w-1)=0; instance(y+h/2:y+h-1,x:x+w-1)=255;
        case 2, instance(y:y+h-1,x:x+w/2-1)=255; instance(y:y+h-1,x+w/2:x+w-1)=0;
        case 3, instance(y:y+h-1,x:x+w/3-1)=255; instance(y:y+h-1,x+w/3:x+2*w/3-1)=0; instance(y:y+h-1,x+2*w/3:x+w-1)=255;
        case 4, instance(y:y+h-1,x:x+w-1)=255; instance(y:y+h/2-1,x:x+w/2-1)=0; instance(y+h/2:y+h-1,x+w/2:x+w-1)=0;
    end
    im = uint8(instance);
end

