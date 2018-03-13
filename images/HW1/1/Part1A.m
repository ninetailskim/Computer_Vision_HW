A = imread('J4Poro.png');

Gaussian_filter1 = fspecial('gaussian',[3 3],5);
Gaussian_filter2 = fspecial('gaussian',[5 5],5);

B3 = imfilter(A,Gaussian_filter1);
B5 = imfilter(A,Gaussian_filter2);

figure;
subplot(1,2,1);imshow(B3);title('kernel¬°3¡G');
subplot(1,2,2);imshow(B5);title('kernel¬°5¡G');

save Part1AData.mat