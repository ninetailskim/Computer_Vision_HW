close all;
A = imread('CaitlinPoro.jpg');
A = im2double(A);
[width,length,~] = size(A);
%--------------------3----------
% A3 = A;
% num = 3;
% kmeans(num,A3,false);
% %--------------------7----------
% A3 = A;
% num = 7;
% kmeans(num,A3,false);
% %--------------------11----------
% A3 = A;
% num = 11;
% kmeans(num,A3,false);
A3 = A;
num = 3;
[image,obj] = kmeans(num,A3,false);
stri = [num2str(num),' OF:',num2str(obj)];
figure;
imshow(image);title(stri);
%--------------------7----------
A3 = A;
num = 7;
[image,obj] = kmeans(num,A3,false);
stri = [num2str(num),' OF:',num2str(obj)];
figure;
imshow(image);title(stri);
%--------------------11----------
A3 = A;
num = 11;
[image,obj] = kmeans(num,A3,false);
stri = [num2str(num),' OF:',num2str(obj)];
figure;
imshow(image);title(stri);