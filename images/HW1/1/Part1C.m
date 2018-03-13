load('Part1AData.mat');

eigv1 = drawH(A,B3,3);
eigv2 = drawH(A,B3,5);
eigv3 = drawH(A,B5,3);
eigv4 = drawH(A,B5,5);

figure;
imshow(showimage(A,eigv1));title('kernel 3, window size 3');
figure;
imshow(showimage(A,eigv2));title('kernel 3, window size 5');
figure;
imshow(showimage(A,eigv3));title('kernel 5, window size 3');
figure;
imshow(showimage(A,eigv4));title('kernel 5, window size 5');

