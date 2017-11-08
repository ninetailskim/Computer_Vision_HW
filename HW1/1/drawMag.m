function [mag] = drawMag(B,ti)
    G = rgb2gray(B);
    xsobel = fspecial('sobel');
    xg = imfilter(G,xsobel);

    ysobel = xsobel';
    yg = imfilter(G,ysobel);

    dyg = im2double(yg);
    dxg = im2double(xg);
    dyg2 = dyg .* dyg;
    dxg2 = dxg .* dxg;
    mag = sqrt(dyg2 + dxg2);
    str = [ti,' Magnitude'];
    figure;
    imshow(mag);title(str);