function [ imRGB  ] = transformYIQ2RGB( imYIQ )
    transformMatrix = inv([0.299 0.587 0.114; 0.596  -0.275  -0.321; 0.212, -0.523, 0.311]);
    %transformMatrix = inv(transformMatrix);
    [rows, cols, dims] = size(imYIQ);
    imRGB = zeros( rows, cols, dims);
    
    imRGB(:, :, 1) = transformMatrix(1,1) * imYIQ(:,:,1) + transformMatrix(1,2) * imYIQ(:,:,2) + transformMatrix(1,3) * imYIQ(:,:,3);
    imRGB(:, :, 2) = transformMatrix(2,1) * imYIQ(:,:,1) + transformMatrix(2,2) * imYIQ(:,:,2) + transformMatrix(2,3) * imYIQ(:,:,3);
    imRGB(:, :, 3) = transformMatrix(3,1) * imYIQ(:,:,1) + transformMatrix(3,2) * imYIQ(:,:,2) + transformMatrix(3,3) * imYIQ(:,:,3);
    
end