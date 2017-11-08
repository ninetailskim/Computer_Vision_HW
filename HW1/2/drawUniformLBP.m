function [resu] = drawUniformLBP(str)
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
    A = imread(str);
    G = rgb2gray(A);
    [width,height] = size(G);
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
            resu(i,j) = table(res + 1);
        end;
    end;
    figure;
    imshow(resu,[]);
