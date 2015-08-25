function [ grey,yiq ] = greyFromImage( imOrig )
%quantizeImage find grey channel from rgb or grey image.
    %init grey
    dimensions = ndims(imOrig);
    if ( dimensions == 3)
       %handle color image     
       yiq = transformRGB2YIQ(imOrig);
       grey = yiq( :, :, 1);
    else
       if ( dimensions == 2)
        grey = im2double(imOrig);
       end
    end
    
   
end