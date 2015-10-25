function [im_out,hist_dist,hist_lvls] =  SR_by_example(im)
%% init stage
hist_dist=0;
load_constants();
hist_lvls = zeros(7,7,'uint16');
%hist_dist = zeros(1,500,'double');
zero_dist = 0;
global LOAD_DATA K W MID EPSILON MAX_PREDS DEFAULT_BG_GREYVAL;


[ im_pyr ] = build_db( im,MID);
highest_lvl_filled = MID;
[ out_x,out_y ] = translate_im_half(im);

%% Init patch database, according to current highest filled layer.
patches_db=[];
qi = [];
qj = [];
qlvl = [];
for lvlq= MID-1:-1:1
    [input_patches_q,lvlq_pi,lvlq_pj] = im2patches(cell2mat(im_pyr(lvlq)));
    patches_db = [patches_db;input_patches_q];
    qi = [qi;lvlq_pi];
    qj = [qj;lvlq_pj];
    qlvl = [qlvl; ones(numel(lvlq_pj),1)*double(lvlq)];
end
[input_patches_p,input_pi,input_pj] = im2patches(cell2mat(im_pyr(MID)));

if (~LOAD_DATA)
    next_target_start = MID+1;
else
    
    load('C:\Users\danny\Documents\MATLAB\projectSRBE3\bin_data\matlab.mat');
    next_target_start = highest_lvl_filled+1;
end;

%% Run knnsearch.
[NNs,D] = knnsearch(patches_db,input_patches_p,'K',K);

%% Upscale by factor ALPHA until reaching target res.
for next_target = next_target_start:NUMCELLS
    
    skipped = 0;
    skipped_no_info=0;
    delta = double(next_target-MID);
    [htg,wtg] = size(cell2mat(im_pyr(next_target)));
    %new_im = zeros(size(cell2mat(im_pyr(next_target))));
    new_im = ones(htg,wtg)*DEFAULT_BG_GREYVAL;
    weighted_dists = zeros(htg,wtg);
    sum_weights = zeros(htg,wtg);
    factor_src = double(htg)/double(size(im,1));
    
    
    
    
    
    
    %% for each nn, compute target patch.
    for p_idx=1:size(NNs,1)
        if(mod(p_idx,1000)==0)            
            formatSpec = 'progress: patch %d/%d';
            str = sprintf(formatSpec,p_idx,size(NNs,1));
            disp(str);
        end
        
        pknns = NNs(p_idx,:);
        %check if the patch nn passes the min thresh criteria
        t_x = thresh( im, out_x, input_pi(p_idx),input_pj(p_idx) );
        t_y = thresh( im, out_y, input_pi(p_idx),input_pj(p_idx) );
        t = (t_x+t_y)/2;
        %taken counts the amount of predictions for current lr example
        %which were set.
        taken = 0;
        for k = 1 : size(D,2)
            
            nn = pknns(k);
            nnParentlvl = qlvl(nn)+delta;
            if (nnParentlvl > highest_lvl_filled)
                skipped_no_info = skipped_no_info + 1;
                continue;
            end
            imp = cell2mat(im_pyr(qlvl(nn)+delta));
            imq = cell2mat(im_pyr(qlvl(nn)));
            
            [child_h,~] = size(cell2mat(im_pyr(qlvl(nn))));
            [parent_h,~] = size(cell2mat(im_pyr(qlvl(nn) + delta)));
            if( taken > 0 && D(p_idx,k) >= t)
                skipped = skipped + 1;
                continue;
            end
            
            lr_patch = input_patches_p(p_idx,:);
            lr_example = patches_db(nn,:);
            lr_example = vec2mat(lr_example,W);
            factor_example = double(parent_h)/double(child_h);
            
            [hr_example,b] = get_parent(imp,imq,qi(nn),qj(nn),factor_example);
            if ( b )
                taken= taken + 1;
                [weighted_dists,sum_weights,new_im] = set_parent( im,input_pi(p_idx),...
                    input_pj(p_idx), new_im,hr_example,...
                    factor_src,weighted_dists,sum_weights,...
                    lr_patch,patches_db(nn,:));
                hist_lvls(qlvl(nn),delta+qlvl(nn)) = hist_lvls(qlvl(nn),delta+qlvl(nn))  + 1;
%                 src_scale_qi = qi(nn)*(ALPHA^(MID-qlvl(nn)));
%                 src_scale_qj = qj(nn)*(ALPHA^(MID-qlvl(nn)));
%                 dist = round(sqrt((input_pi(p_idx)-src_scale_qi)^2 + (input_pj(p_idx)-src_scale_qj)^2));
%                 if(dist == 0)
%                     zero_dist = zero_dist + 1;
%                 else
%                     %hist_dist(dist) =  hist_dist(dist) + 1;
%                 end
            end
        end
    end
    
    new_im = weighted_dists./sum_weights;
    new_im(isnan(new_im)) = DEFAULT_BG_GREYVAL;
    new_im = imsharpen(new_im);
    imshow(new_im);
    im_pyr(next_target) = {new_im};
    %add new learned patches to db.
    highest_lvl_filled = next_target;
    
end

im_out = new_im;

end
