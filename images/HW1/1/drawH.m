function [eigv] = drawH(A,B,si)

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
    dxyg = dxg .* dyg;

    si = (si-1)/2;
    
    [width,height] = size(G);
    H1 = zeros(width,height);
    H2 = zeros(width,height);
    H3 = zeros(width,height);
    for i = si + 1:width - si
        for j = si + 1:height - si
            for k = i - si:i + si
                for l = j - si:j + si
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