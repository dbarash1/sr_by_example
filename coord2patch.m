function [ p ] = coord2patch( im,i,j,step )
    psize = (step*2+1)^2;
    [h,w] = size(im);
    p = [];
    if ( ~checkbounds( h,w,i,j,step ))
        return;
    end
    p = im((i-step):(i+step),(j-step):(j+step));
    p = reshape(p',1,psize);   
end

