function [ imYIQ  ] = transformRGB2YIQ( imRGB )
    
    imRGB = im2double(imRGB);
    [rows, cols, dims] = size(imRGB);
    imYIQ = zeros( rows, cols, dims);
    
    imYIQ(:,:,1) = 0.299 * imRGB(:,:,1) + 0.587 * imRGB(:,:,2) + 0.114 * imRGB(:,:,3);
    imYIQ(:,:,2) = 0.596 * imRGB(:,:,1) - 0.275 * imRGB(:,:,2) - 0.321 * imRGB(:,:,3);
    imYIQ(:,:,3) = 0.212 * imRGB(:,:,1) - 0.523 * imRGB(:,:,2) + 0.311 * imRGB(:,:,3);
end