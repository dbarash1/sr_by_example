function [ imYIQ  ] = transformRGB2YIQ( imRGB )
    
    imRGB = im2double(imRGB);
    [rows, cols, dims] = size(imRGB);
    imYIQ = zeros( rows, cols, dims);
    
    imYIQ(:,:,1) = 0.299 * imRGB(:,:,1) + 0.587 * imRGB(:,:,2) + 0.114 * imRGB(:,:,3);
    imYIQ(:,:,2) = 0.596 * imRGB(:,:,1) - 0.275 * imRGB(:,:,2) - 0.321 * imRGB(:,:,3);
    imYIQ(:,:,3) = 0.212 * imRGB(:,:,1) - 0.523 * imRGB(:,:,2) + 0.311 * imRGB(:,:,3);

% transformMatrix = [0.299 0.587 0.114; 0.596  -0.275  -0.321; 0.212, -0.523, 0.311];  
%     for row = 1:rows
%         for col = 1: cols
%             rgbVec = [imRGB(row,col,1) imRGB(row,col,2) imRGB(row,col,3)]';
%             yiqVec = int8(double(transformMatrix) * double(rgbVec));
%             imYIQ(row, col, :) = yiqVec;
%         end;
%     end;
end