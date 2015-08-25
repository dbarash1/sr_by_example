function [patches_p,pi,pj] = im2patches( imp )
    global PATCH_SIZE STEP;
    [hp,wp] = size(imp);
    %init vars
    
    numPatches=hp*wp;
    patches_p = zeros(numPatches,PATCH_SIZE);
    pi = zeros(numPatches,1);
    pj = zeros(numPatches,1);
    
    pindx = 0;
    for r=1+STEP:hp-STEP
        for c = 1+STEP:wp-STEP
            pindx = pindx + 1;
            p = imp((r-STEP):(r+STEP),(c-STEP):(c+STEP));
            patches_p(pindx,:) = reshape(p',1,PATCH_SIZE);                            
            pi(pindx) = r;
            pj(pindx) = c;
        end
    end
    
    %cut down unused cells.
    patches_p = patches_p(1:pindx,:);
    pi = pi(1:pindx);
    pj = pj(1:pindx);
end

