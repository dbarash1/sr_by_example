function [ imRGB,imGrey,hist,orig ] = run_color_SR( fname )
    %% nature image 1
    orig = imread(fname);
    [ grey,~ ] = greyFromImage(orig);
    imbig = imresize(orig,2);
    [ ~,yiqBig ] = greyFromImage(imbig);
    %%run 
    [imGrey,hist]=SR_by_example(grey);
    yiqBig( :, :, 1) = imGrey;
    [ imRGB  ] = transformYIQ2RGB( yiqBig );


end

