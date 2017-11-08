str = 'kobeFace.png';
kobeFace = imread(str);
gasolFace = imread('gasolFace.png');
GA = rgb2gray(kobeFace);
GB = rgb2gray(gasolFace);
[width,height] = size(GA);
resu = zeros(width,height);
neig = zeros(1,8);
for i = 2:width - 1
    for j = 2:height - 1
        res = 0;
        center = G(i,j);
        wei = 1;
        neig(1) = G(i - 1,j - 1);
        neig(2) = G(i - 1,j);
        neig(3) = G(i - 1,j + 1);
        neig(4) = G(i,j + 1);
        neig(5) = G(i + 1,j + 1);
        neig(6) = G(i + 1,j);
        neig(7) = G(i + 1,j - 1);
        neig(8) = G(i,j - 1);
        for k = 1:8
            if neig(k) >= center
                res = res + wei;
            end;
            wei = wei * 2;
        end;
        resu(i,j) = res;
    end;
end;
[width,height] = size(GB);
resuB = zeros(width,height);
neig = zeros(1,8);
for i = 2:width - 1
    for j = 2:height - 1
        res = 0;
        center = GB(i,j);
        wei = 1;
        neig(1) = GB(i - 1,j - 1);
        neig(2) = GB(i - 1,j);
        neig(3) = GB(i - 1,j + 1);
        neig(4) = GB(i,j + 1);
        neig(5) = GB(i + 1,j + 1);
        neig(6) = GB(i + 1,j);
        neig(7) = GB(i + 1,j - 1);
        neig(8) = GB(i,j - 1);
        for k = 1:8
            if neig(k) >= center
                res = res + wei;
            end;
            wei = wei * 2;
        end;
        resuB(i,j) = res;
    end;
end;
%resw = im2double(resu);
subplot(1,2,1);imshow(resu,[]);
subplot(1,2,2);imshow(resuB,[]);
drawLBP(str);
%1 2 4 8 16 32 64 128