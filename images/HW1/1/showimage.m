function [showimg] = showimage(A,eigv)
    showimg = A;
    [Y,X,O] = size(showimg);
    showimg(1:Y,1:X,1:2) = 0;
    [width,height] = size(rgb2gray(A));
    for i = 1:width
        for j = 1:height
            if eigv(i,j) == 1
                showimg(i,j,1:3) = 255;
            end;
        end;
    end;