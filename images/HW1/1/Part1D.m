load('Part1CData.mat');

Gaussian = fspecial('gaussian',[3 3],5);

figure;
imshow(showimage(A,drawP(A,eigv1,Gaussian)));title('kernel 3, window size 3');
figure;
imshow(showimage(A,drawP(A,eigv2,Gaussian)));title('kernel 3, window size 5');
figure;
imshow(showimage(A,drawP(A,eigv3,Gaussian)));title('kernel 5, window size 3');
figure;
imshow(showimage(A,drawP(A,eigv4,Gaussian)));title('kernel 5, window size 5');