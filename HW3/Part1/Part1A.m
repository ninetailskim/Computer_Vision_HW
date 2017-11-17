A = imread('CaitlinPoro.jpg');
A = im2double(A);
[width,length,~] = size(A);
%--------------------3----------
A3 = A;
num = 3;
[image,obj] = kmeans(num,A3,true);
stri = [num2str(num),' OF:',num2str(obj)];
figure;
imshow(image);title(stri);
%--------------------7----------
A3 = A;
num = 7;
[image,obj] = kmeans(num,A3,true);
stri = [num2str(num),' OF:',num2str(obj)];
figure;
imshow(image);title(stri);
%--------------------11----------
A3 = A;
num = 11;
[image,obj] = kmeans(num,A3,true);
stri = [num2str(num),' OF:',num2str(obj)];
figure;
imshow(image);title(stri);
