clear;
close all;

%% nature image 1
figure;
[ imRGBnature1,imGreynature1,histnature1,orignature1 ] = run_color_SR( 'nature1.jpg' );

%% pattern
figure;
impattern = imread('pattern.png');
impattern = im2double(impattern);
[im_out_pattern,~]=SR_by_example(impattern);



