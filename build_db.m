function [ im_pyr ] = build_db( im, imlvl)

global ALPHA BLUR_KERNEL NUMCELLS MID EPSILON MIN_WH INTERP_METHOD_DS;
im_pyr = cell(NUMCELLS,1);
%create im_pyr
for level = 1 : MID-1
    diff = double(level)-double(imlvl);
    new_size = size(im)*ALPHA ^ diff;
    new_size_decim = floor(new_size + EPSILON);
    %This is because Matlab "floors" X.000 to X-1.
%     if ( abs(floor(new_size(1)) - new_size(1) +1) <= EPSILON)
%         new_size_decim = round(new_size);
%     end
%     assert(new_size_decim(1)> MIN_WH);
%     assert(new_size_decim(2)> MIN_WH);
%     
%     
%     blurred = conv2(im,BLUR_KERNEL,'same');
%     y = 1:new_size_decim(1);
%     scale= ALPHA ^ diff;
%     Y = y/scale + 0.5*(1-1/scale);
%     %Y = 1:ALPHA ^ (-diff):size(im,1); 
%     x = 1:new_size_decim(2);
%     X = x/scale + 0.5*(1-1/scale);
%     X=repmat(X,numel(Y),1);
%     Y=repmat(Y',1,size(X,2));
%     V = interp2(blurred,X,Y,'linear');
%     im_pyr(level) = {V};

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

