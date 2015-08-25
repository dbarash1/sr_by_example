function [ dstx,dsty ] = move_level( src_level,srcx,srcy,dst_level)
    %reverse to matlabs mapping function in imresize
    [sh,sw] = size(src_level);
    [dh,dw] = size(dst_level);
    scale_x = dw/sw;
    scale_y = dh/sh;
    dstx = scale_x*srcx - 0.5*scale_x*(1-1/scale_x);
    dsty = scale_y*srcy - 0.5*scale_y*(1-1/scale_y);
end