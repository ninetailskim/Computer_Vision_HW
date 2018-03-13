clear 
run('../VLFEATROOT/toolbox/vl_setup')
load('BOOK_POINTS.mat');
scene = imread('scene.jpg');

book1 = imread('book1.jpg');

book2 = imread('book2.jpg');

book3 = imread('book3.jpg');

%book1-------0.05
%book2-------0.6
%book3-------0.27
%book1-------800
RANSAC(scene,book1,0.05,15,book1Points);
RANSAC(scene,book2,0.6,10,book2Points);
RANSAC(scene,book3,0.27,20,book3Points);


