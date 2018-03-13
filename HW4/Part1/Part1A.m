clear
run('../VLFEATROOT/toolbox/vl_setup')

scene = imread('scene.jpg');
book1 = imread('book1.jpg');
book2 = imread('book2.jpg');
book3 = imread('book3.jpg');

%book1-------0.05
%book2-------0.6
%book3-------0.27
resshow(book1,scene,0.05);
resshow(book1,scene,0.1);

resshow(book2,scene,0.6);
resshow(book2,scene,0.65);

resshow(book3,scene,0.27);
resshow(book3,scene,0.32);
