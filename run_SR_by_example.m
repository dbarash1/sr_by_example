clear;
close all;

%% nature image 1
figure;
[ imRGBnature1,imGreynature1,histnature1,orignature1 ] = run_color_SR( 'nature1.jpg' );

figure;
[ imRGBin_road1,imGreyin_road1,histin_road1,origin_road1 ] = run_color_SR( 'road1.jpg' );

figure;
[ imRGBin_house2,imGreyin_house2,histin_house2,origin_house2 ] = run_color_SR( 'in_house2.jpg' );

%% pattern
figure;
impattern = imread('pattern.png');
impattern = im2double(impattern);
[im_out_pattern,~]=SR_by_example(impattern);





%% nature image 2
figure;
[ imRGBnature2,imGreynature2,histnature2,orignature2 ] = run_color_SR( 'nature2.jpg');



%% Artificial image.
% im = im2double(im);
% im = double(ones(50,50));
% im(20:30,:) = 0;
% [im_out_grey,hist_dist]=SR_by_example(im);





figure;
[ imRGBin_house1,imGreyin_house1,histin_house1,origin_house1 ] = run_color_SR( 'in_house1.jpg' );



