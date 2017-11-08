load('rotateData.mat');
load('scaleData.mat');
load('Part1CData.mat');

showimg = A;
[Y,X,O] = size(showimg);
showimg(1:Y,1:X,1:3) = showimg(1:Y,1:X,1:3) / 2;

nms = imfilter(eigv1,Gaussian);

[width,height] = size(rgb2gray(A));

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

count1 = 0;
count2 = 0;
count3 = 0;

for i = 1:width
    for j = 1:height
        if resu(i,j) == 1
            showimg(i,j,1) = 255;
            showimg(i,j,2:3) = 0;
            count1 = count1 + 1;
        end;
    end;
end;

for i = 1:width
    for j = 1:height
        if resss(i,j) == 1
            showimg(i,j,1) = 0;
            showimg(i,j,2) = 255;
            showimg(i,j,3) = 0;
            count2 = count2 + 1;
        end;
    end;
end;

for i = 1:width
    for j = 1:height
        if rescale(i,j) == 1
            showimg(i,j,1) = 0;
            showimg(i,j,3) = 255;
            showimg(i,j,2) = 0;
            count3 = count3 + 1;
        end;
    end;
end;
figure;
imshow(showimg);

count1
count2
count3
