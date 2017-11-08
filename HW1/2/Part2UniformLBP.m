A = imread('kobeFace.png');
GA = rgb2gray(A);
B = imread('gasolFace.png');
GB = rgb2gray(B);

%ªì©l¤Ætable
table = zeros(1,256);
temp = 1;
for i = 1:256
    tt = getJump(i - 1);
    if tt <= 2
        table(i) = temp;
        temp = temp + 1;
    end;
end;

[width,height] = size(GA);
resu = zeros(width,height);
neig = zeros(1,8);
for i = 2:width - 1
    for j = 2:height - 1
        res = 0;
        center = GA(i,j);
        wei = 1;
        neig(1) = GA(i - 1,j - 1);
        neig(2) = GA(i - 1,j);
        neig(3) = GA(i - 1,j + 1);
        neig(4) = GA(i,j + 1);
        neig(5) = GA(i + 1,j + 1);
        neig(6) = GA(i + 1,j);
        neig(7) = GA(i + 1,j - 1);
        neig(8) = GA(i,j - 1);
        for k = 1:8
            if neig(k) >= center
                res = res + wei;
            end;
            wei = wei * 2;
        end;
        resu(i,j) = table(res + 1);
    end;
end;
[width,height] = size(GA);
resu = zeros(width,height);
neig = zeros(1,8);
for i = 2:width - 1
    for j = 2:height - 1
        res = 0;
        center = GA(i,j);
        wei = 1;
        neig(1) = GA(i - 1,j - 1);
        neig(2) = GA(i - 1,j);
        neig(3) = GA(i - 1,j + 1);
        neig(4) = GA(i,j + 1);
        neig(5) = GA(i + 1,j + 1);
        neig(6) = GA(i + 1,j);
        neig(7) = GA(i + 1,j - 1);
        neig(8) = GA(i,j - 1);
        for k = 1:8
            if neig(k) >= center
                res = res + wei;
            end;
            wei = wei * 2;
        end;
        resu(i,j) = table(res + 1);
    end;
end;

%resw = im2double(resu);
imshow(resu,[]);
%1 2 4 8 16 32 64 128
