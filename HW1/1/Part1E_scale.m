A = imread('J4Poro.png');

A = imresize(A,0.5);

Gaussian_filter = fspecial('gaussian',[3 3],5);
B = imfilter(A,Gaussian_filter);

xsobel = fspecial('sobel');
G = rgb2gray(B);
G = im2double(G);
xg = imfilter(G,xsobel);

ysobel = xsobel';
yg = imfilter(G,ysobel);

dyg = im2double(yg);
dxg = im2double(xg);
dyg2 = dyg .* dyg;
dxg2 = dxg .* dxg;

%-------------------C------------------------------

dxyg = dxg .* dyg;

[width,height] = size(G);
H1 = zeros(width,height);
H2 = zeros(width,height);
H3 = zeros(width,height);
for i = 2:width - 1
    for j = 2:height - 1
        for k = i - 1:i + 1
            for l = j - 1:j + 1
                H1(i,j) = H1(i,j) + dxg2(k,l);
                H2(i,j) = H2(i,j) + dxyg(k,l);
                H3(i,j) = H3(i,j) + dyg2(k,l);
            end;
        end;
    end;
end;
eigv = zeros(width,height);
temp = zeros(2,2);
for i = 2:width - 1
    for j = 2:height - 1
        temp(1,1) = H1(i,j);
        temp(1,2) = H2(i,j);
        temp(2,1) = H2(i,j);
        temp(2,2) = H3(i,j);
        eigv(i,j) = min(eig(temp));
    end;
end;

eigv(eigv>0.1)=1;
eigv(eigv<=0.1)=0;

%--------------D-----------------------

showimg = A;
[Y,X,O] = size(showimg);
showimg(1:Y,1:X,1:2) = 0;

eigvx = imresize(eigv,2);

Gaussian = fspecial('gaussian',[3 3],5);
nms = imfilter(eigv,Gaussian);
nmsx = imfilter(eigvx,Gaussian);
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

resux = zeros(1080,1920);

for i = 2:1079
    for j = 2:1919
        center = nmsx(i,j);
        if (center > nmsx(i-1,j-1) & center > nmsx(i-1,j) & center > nmsx(i-1,j+1) & center > nmsx(i,j-1) & center > nmsx(i,j+1) & center > nmsx(i+1,j-1) & center > nmsx(i+1,j) & center > nmsx(i+1,j+1))
            resux(i,j) = 1;
        else
            resux(i,j) = 0;
        end;
    end;
end;

rescale = resux;
%rescale = imresize(resu,2);
tttem = rescale;

for i = 1:width
    for j = 1:height
        if resu(i,j) == 1
            showimg(i,j,1:3) = 255;
        end;
    end;
end;

figure;
imshow(showimg);

%--------------------------5
[width,height] = size(G);
H1 = zeros(width,height);
H2 = zeros(width,height);
H3 = zeros(width,height);
for i = 3:width - 2
    for j = 3:height - 2
        for k = i - 2:i + 2
            for l = j - 2:j + 2
                H1(i,j) = H1(i,j) + dxg2(k,l);
                H2(i,j) = H2(i,j) + dxyg(k,l);
                H3(i,j) = H3(i,j) + dyg2(k,l);
            end;
        end;
    end;
end;
eigv = zeros(width,height);
temp = zeros(2,2);
for i = 3:width - 2
    for j = 3:height - 2
        temp(1,1) = H1(i,j);
        temp(1,2) = H2(i,j);
        temp(2,1) = H2(i,j);
        temp(2,2) = H3(i,j);
        eigv(i,j) = min(eig(temp));
    end;
end;

eigv(eigv>0.1)=1;
eigv(eigv<=0.1)=0;

%--------------D-----------------------

showimg = A;
[Y,X,O] = size(showimg);
showimg(1:Y,1:X,1:2) = 0;

nms = imfilter(eigv,Gaussian);
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

for i = 1:width
    for j = 1:height
        if resu(i,j) == 1
            showimg(i,j,1:3) = 255;
        end;
    end;
end;

figure;
imshow(showimg);

% figure;
% imshow(rescale);

% for i = 1:1080
%     for j = 1:1920
%         if rescale(i,j) ~= 0 
%             rescale(i,j) = 1;
%         end;
%     end;
% end;

% figure;
% imshow(rescale);
% 
% Gau = fspecial('gaussian',[3 3],5);
% tempscale = imfilter(rescale,Gau);
% tempscale = imfilter(tempscale,Gau);
% figure;
% imshow(tempscale);
% 
% rescale = zeros(1080,1920);
% 
% for i = 2:1079
%     for j = 2:1919
%         center = tempscale(i,j);
%         if (center > tempscale(i-1,j-1) & center > tempscale(i-1,j) & center > tempscale(i-1,j+1) & center > tempscale(i,j-1) & center > tempscale(i,j+1) & center > tempscale(i+1,j-1) & center > tempscale(i+1,j) & center > tempscale(i+1,j+1))
%             rescale(i,j) = 1;
%         else
%             rescale(i,j) = 0;
%         end;
%     end;
% end;
% 
% figure;
% imshow(rescale);
%
