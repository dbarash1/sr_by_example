function [dist] = distance(lr_patch,lr_example)
global MIN_STD ;

sigma = std(lr_example);
if(sigma == 0)
    sigma = MIN_STD;
end
%sigma = 1;
ssd = sum(sum((lr_patch - lr_example).^2));
dist = exp(-ssd/sigma);
end

