function [res] = getHist(a,i)
    res = zeros(1,i);
    [width,height] = size(a);
    for i = 2:width - 1
        for j = 2:height - 1
            res(a(i,j) + 1) = res(a(i,j) + 1) + 1;
        end;
    end;