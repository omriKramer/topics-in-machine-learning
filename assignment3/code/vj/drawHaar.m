% Return the filter mask for the Haar wavelet whose index is Fuse (5x1 vector) 

function im=drawHaar(Fuse)
    if (size(Fuse,2)~=1) error('Only draws one filter.'); end;
    im=zeros(24,24);
    x=Fuse(2,:); y=Fuse(3,:); w=Fuse(4,:); h=Fuse(5,:); htype=Fuse(1,:);
    switch htype
        case 1, im(y:y+h/2-1,x:x+w-1)=1; im(y+h/2:y+h-1,x:x+w-1)=-1;
        case 2, im(y:y+h-1,x:x+w/2-1)=-1; im(y:y+h-1,x+w/2:x+w-1)=1;
        case 3, im(y:y+h-1,x:x+w/3-1)=-1; im(y:y+h-1,x+w/3:x+2*w/3-1)=1; im(y:y+h-1,x+2*w/3:x+w-1)=-1;
        case 4, im(y:y+h-1,x:x+w-1)=-1; im(y:y+h/2-1,x:x+w/2-1)=1; im(y+h/2:y+h-1,x+w/2:x+w-1)=1;
    end
end

