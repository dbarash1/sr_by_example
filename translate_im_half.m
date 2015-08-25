function [ out_x,out_y ] = translate_im_half( im )
    global INTERP_METHOD EPSILON;
    [h,w] = size(im);
    im_new_y = zeros(h+1,w);
    im_new_y(2:end,:) = im;
    im_new_y(1,:) = im_new_y(2,:);
    [X,Y] = meshgrid(1:w,1:h);
    Y= Y+0.5;
    out_y = interp2(im_new_y,X,Y,INTERP_METHOD);
    
    im_new_x = zeros(h,w+1);
    im_new_x(:,2:end) = im;
    im_new_x(:,1) = im_new_x(:,2);
    [X,Y] = meshgrid(1:w,1:h);
    X= X+0.5;
    out_x = interp2(im_new_x,X,Y,INTERP_METHOD);
     
    
    
end

