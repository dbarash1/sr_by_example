function [ bool ] = checkbounds( h,w,i,j,step )
    if ( i-step < 1 || i+step > h || j-step < 1 || j+step > w)
        bool= 0;
    else
        bool= 1;
    end

end

