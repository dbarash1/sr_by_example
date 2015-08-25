function [weighted_dists,sum_weights,new_im] = set_parent(curr_im, curr_pi, curr_pj, new_im,hr_example, factor,weighted_dists,sum_weights,lr_patch,lr_example)


global W EPSILON INTERP_METHOD STEP ALPHA;

[ pj,pi ] = move_level( curr_im,curr_pj,curr_pi,new_im);

pi2 = curr_pi*factor;
pj2 = curr_pj*factor;
[h,w] = size(new_im);

% parent_patch_width = ALPHA * W;
% parent_half_width = parent_patch_width/2 - 1;
% step = parent_half_width;
step = STEP;
w_blur = W;
if(checkbounds( h,w,pi,pj,step ))
    %rectange to set
    
    left = ceil(pj-step);
    right = floor(pj+step);
    top = ceil(pi-step);
    bottom = floor(pi+step);
    Xqt = left:right;
    Yqt = top:bottom;
    
    dist_getx = Xqt - pj;
    coord_setx = hr_example.pj + dist_getx;
    
    dist_gety = Yqt - pi;
    coord_sety = hr_example.pi + dist_gety;
    
    
    [Xq,Yq] = meshgrid(coord_setx,coord_sety);
    Vq = interp2(hr_example.image,Xq,Yq,INTERP_METHOD);
    
    Vq(Vq<0) = 0;
    Vq(Vq>1) = 1;
    
    assert(~any(any(isnan(Vq))));   
    
    
    weight = distance(lr_patch,lr_example); 
    weights = weight;
    sum_weights(top:bottom, left:right) = sum_weights(top:bottom, left:right) + weights;
    weighted_dists(top:bottom,left:right) = weighted_dists(top:bottom,left:right) + Vq.*weights;    
    
end



end


