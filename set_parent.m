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
%     [h,w] = size(zeros(1+bottom-top,1+right-left));
%     [xx, yy] = meshgrid(1:w,1:h);
%     dists_mat = max(abs(xx-ceil(w/2)),abs(yy-ceil(h/2)))+1;
%     dists_mat = ones(size(dists_mat))./dists_mat;
%     dists_mat = fspecial('gaussian',W );
%     dists_mat=dists_mat(1:h,1:w);
%     weights = dists_mat.*weight;
    weights = weight;
    sum_weights(top:bottom, left:right) = sum_weights(top:bottom, left:right) + weights;
    weighted_dists(top:bottom,left:right) = weighted_dists(top:bottom,left:right) + Vq.*weights;% + reshape(dist_pixel_from_center',1,numel(dist_pixel_from_center));
    
     %for debugging purposes
%     for i = top:bottom
%         for j = left:right
%             %num_preds(i,j) = num_preds(i,j) + 1;
%             assert(num_preds(i,j)<=MAX_PREDS);
%             dist_pixel_from_center_tst = sqrt(((i+0.5) - pi)^2 + ((j+0.5) - pj)^2);
%             distances_test(i,j,num_preds(i,j)) = distance(lr_patch,lr_example) + dist_pixel_from_center_tst;
%             preds(i,j,num_preds(i,j)) = Vq(1+i-top,j+1-left);
%             assert(abs(preds_test(i,j,num_preds(i,j)) - preds(i,j,num_preds(i,j))) < EPSILON);
%             assert(abs(distances(i,j,num_preds(i,j)) - distances_test(i,j,num_preds(i,j))) < EPSILON);
%         end
%     end
    
end



end


