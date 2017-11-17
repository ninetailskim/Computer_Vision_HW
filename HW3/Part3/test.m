% a = [1 5 2 7 4 9 3 6];
% 
% a(a <= 5) = 1;
% a
% 
% tes = zeros(2,2,3);
% tes(:,:,1) = 1;
% 
% tes(1,1,2) = 0.2;
% tes(1,2,2) = 0.8;
% tes(2,2,2) = 0.4;
% tes(2,1,2) = 0.6;
% 
% tes(1,1,3) = 0.4;
% tes(1,2,3) = 0.7;
% tes(2,2,3) = 0.3;
% tes(2,1,3) = 0.6;
% 
% tes
% 
% tes(:,:,3) = 0;
% 
% tes
A = imread('AmumuPoro.jpg');

[width,height,~] = size(A); 
% B = imresize(A,0.3);
B = A;
B = im2double(B);
figure;
imshow(B);

figure;
SCA = reshape(B,[],3);
% c = 
scatter3(SCA(:,1),SCA(:,2),SCA(:,3),1,SCA);