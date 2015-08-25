function [eq] = get_next_eq(H_lvl,nn,im_pyr,mesh_hresX,mesh_hresY,gauss_step,blur_kernel,nexteq_indx)



p = cell2mat(nn(1));
q = cell2mat(nn(2));
sec = cell2mat(nn(4));

num_eqs = (((1 + p.level - q.level)*2+1) ^ 2) * 9;
sparse_i = uint32(zeros(num_eqs,1));
sparse_j = uint32(zeros(num_eqs,1));
sparse_v = double(zeros(num_eqs,1));
y= uint32(zeros(num_eqs,1));
cpy_patch_lvl = H_lvl-1;
imp = cell2mat(im_pyr(p.level));
imq = cell2mat(im_pyr(q.level));

size_eqim = size(cell2mat(im_pyr(cpy_patch_lvl)));
size_H = size(cell2mat(im_pyr(H_lvl)));
size_curr = size(imp);
size_low = size(cell2mat(im_pyr(q.level)));
factp = size_eqim/size_curr;
factq = size_curr/size_low;
facth = size_H/size_eqim;
UPSCALED_STEP = p.level - q.level;
%patch P with content Q in location Pi,Pj is the learned patch.
Q = coord2patch(imp,round(factq*q.i),round(factq*q.j), UPSCALED_STEP);

if(isempty(Q))
    eq=[];
    return;
end

Pi = round(factp*p.i);
Pj = round(factp*p.j);


if( ~checkbounds( size_eqim(1),size_eqim(2),Pi,Pj,UPSCALED_STEP ))
    eq=[];
    return;
end


%each pixel in the neighbour patch, in current level, gives one equation in the
%parent of the current patch in curr.

start_i=(Pi-UPSCALED_STEP);
start_j = (Pj-UPSCALED_STEP);
pp_rows = start_i : start_i + 2*UPSCALED_STEP;
pp_cols = start_j : start_j + 2*UPSCALED_STEP;



sparse_indx = 1;
Q_idx = 1;
y_idx = 1;
for Pi=pp_rows
    for Pj = pp_cols
        Hi = round(Pi * facth);
        Hj = round(Pj * facth);        
        if (~checkbounds( size_H(1),size_H(2),Hi,Hj,gauss_step ))
            continue;
        end
        X=mesh_hresX(Hi-gauss_step:Hi+gauss_step,Hj-gauss_step:Hj+gauss_step);
        Y=mesh_hresY(Hi-gauss_step:Hi+gauss_step,Hj-gauss_step:Hj+gauss_step);
        Y = (Y-1) * size_H(2);
        Y = Y + X;
        Y = reshape(Y',1,numel(X));
        
        %add equations according to how closely they relate
        %to the original patch.
        for mul = 1 : sec
            sparse_i(sparse_indx:sparse_indx+numel(X)-1) = nexteq_indx;
            sparse_j(sparse_indx:sparse_indx+numel(X)-1) = Y;
            sparse_v(sparse_indx:sparse_indx+numel(X)-1) = blur_kernel;
            y(y_idx) = Q(Q_idx);
            sparse_indx=sparse_indx+numel(X);
            nexteq_indx = nexteq_indx + 1;
            y_idx = y_idx + 1;
        end
        Q_idx = Q_idx + 1;
    end
end



%remove unused cells.
sparse_i = double(sparse_i(1:sparse_indx- 1));
sparse_j = double(sparse_j(1:sparse_indx- 1));
sparse_v = sparse_v(1:sparse_indx- 1);
y = double(y(1:y_idx-1));


eq = struct('i',sparse_i, 'j',sparse_j,'v',sparse_v,'y',y);

end

