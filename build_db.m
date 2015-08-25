function [ im_pyr ] = build_db( im, imlvl)

global ALPHA BLUR_KERNEL NUMCELLS MID EPSILON MIN_WH INTERP_METHOD_DS;
im_pyr = cell(NUMCELLS,1);
%create im_pyr
for level = 1 : MID-1
    diff = double(level)-double(imlvl);
    new_size = size(im)*ALPHA ^ diff;
    new_size_decim = floor(new_size + EPSILON);
      im_pyr(level) = {imresize(im,new_size_decim,INTERP_METHOD_DS)};
end
im_pyr(MID) = {im};
for level = MID+1 : NUMCELLS
    diff = double(level)-double(imlvl);
    new_size = size(im)*ALPHA ^ diff;
    new_size_decim = floor(new_size);
    im_pyr(level) = {zeros(new_size_decim)};
end
end

