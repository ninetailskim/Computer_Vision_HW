function [resu] = drawP(A,eigv,Gaussian)

nms = imfilter(eigv,Gaussian);

[width,height]=size(rgb2gray(A));

resu = zeros(width,height);

for i = 2:width - 1
    for j = 2:height - 1
        center = nms(i,j);
        if (center > nms(i-1,j-1) & center > nms(i-1,j) & center > nms(i-1,j+1) & center > nms(i,j-1) & center > nms(i,j+1) & center > nms(i+1,j-1) & center > nms(i+1,j) & center > nms(i+1,j+1))
            resu(i,j) = 1;
        else
            resu(i,j) = 0;
        end;
    end;
end;
