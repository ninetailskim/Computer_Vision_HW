function Dir = drawDir(B,mag,ti)
    xsobel = fspecial('sobel');
    G = rgb2gray(B);
    G = im2double(G);
    xg = imfilter(G,xsobel);

    ysobel = xsobel';
    yg = imfilter(G,ysobel);
    
    Diratand = atand(yg./(xg+0.0000000001));

    %對Diratand進行歸一化

    Diratand = (Diratand + 90)./180.0;

    hsvMap = linspace( 0, 1, 99 )' ;
    hsvMap(:, 2) = 0.5;
    hsvMap(:, 3) = 1;
    rgbMap = hsv2rgb(hsvMap);
    rgbMap = [ 0.2 0.2 0.2 ; rgbMap ];

    threshold = 0.2;
    Diratand(mag < threshold) = 0;
    str = [ti,' Direction:'];
    figure;
    imshow(Diratand,'ColorMap',rgbMap);title(str);