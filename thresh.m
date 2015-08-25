function [ t ] = thresh( im, im_translated, patch_center_x,patch_center_y)
    global STEP;
    p1 = coord2patch( im,patch_center_x,patch_center_y,STEP );
    p2 = coord2patch( im_translated,patch_center_x,patch_center_y,STEP );
    t = distance(p1,p2);
end
    