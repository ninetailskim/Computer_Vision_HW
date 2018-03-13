clear
run('../VLFEATROOT/toolbox/vl_setup')

left = imread('left.jpg');
center = imread('center.jpg');
right = imread('right.jpg');

slleft = single(rgb2gray(left));
slcenter = single(rgb2gray(center));
slright = single(rgb2gray(right));

[FL,DL] = vl_sift(slleft);
[FC,DC] = vl_sift(slcenter);
[FR,DR] = vl_sift(slright);

matchLC = getmatch(0.5,DC,DL);
matchRC = getmatch(0.1,DC,DR);

matchLCP = round(match2Point(matchLC,FL,FC));
matchRCP = round(match2Point(matchRC,FR,FC));

drawline(left,center,matchLCP);
drawline(right,center,matchRCP);



