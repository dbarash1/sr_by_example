function [parent_patch,b] = get_parent(imp,imq,qi,qj,factor)
    global STEP ALPHA W;
    [ pj,pi ] = move_level( imq,qj,qi,imp);
    
    pi2 = double(qi)*factor;
    pj2 = double(qj)*factor;
    [h,w]=size(imp);
%     parent_patch_width = factor * W;
%     parent_half_width = parent_patch_width/2 - 1;
%     step = parent_half_width;
     step = STEP;
    if(checkbounds( h,w,pi,pj,step ))
        parent_patch = struct('image',imp,'pi',pi,'pj',pj);
        b = true;
    else
        parent_patch=0;
        b = false;
    end

end