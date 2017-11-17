B = imread('CaitlinPoro.jpg');
A = B;
%LUV = rgb2luv(A);
[w,h,~] = size(A);
A = im2double(A); 

for i = 1:w
    for j = 1:h      
        A(i,j,:) = Net_rgb2luv(A(i,j,:));
    end
end 

max1 = max(max(A(:,:,1)));
min1 = min(min(A(:,:,1)));
max2 = max(max(A(:,:,2)));
min2 = min(min(A(:,:,2)));
max3 = max(max(A(:,:,3)));
min3 = min(min(A(:,:,3)));

A(:,:,1) = (A(:,:,1) - min1) / (max1 - min1);
A(:,:,2) = (A(:,:,2) - min2) / (max2 - min2);
A(:,:,3) = (A(:,:,3) - min3) / (max3 - min3);

A3 = A;
num = 3;
[image,obj] = kmeans(num,A3,false);
image(:,:,1) = image(:,:,1) * (max1 - min1) + min1;
image(:,:,2) = image(:,:,2) * (max2 - min2) + min2;
image(:,:,3) = image(:,:,3) * (max3 - min3) + min3;
for i = 1:w
    for j = 1:h      
        image(i,j,:) = Net_luv2rgb(image(i,j,:));
    end
end  
stri = [num2str(num),' OF:',num2str(obj)];
figure;
imshow(image);title(stri);
%--------------------7----------
A3 = A;
num = 7;
[image,obj] = kmeans(num,A3,false);
image(:,:,1) = image(:,:,1) * (max1 - min1) + min1;
image(:,:,2) = image(:,:,2) * (max2 - min2) + min2;
image(:,:,3) = image(:,:,3) * (max3 - min3) + min3;
for i = 1:w
    for j = 1:h      
        image(i,j,:) = Net_luv2rgb(image(i,j,:));
    end
end  
stri = [num2str(num),' OF:',num2str(obj)];
figure;
imshow(image);title(stri);
%--------------------11----------
A3 = A;
num = 11;
[image,obj] = kmeans(num,A3,false);
image(:,:,1) = image(:,:,1) * (max1 - min1) + min1;
image(:,:,2) = image(:,:,2) * (max2 - min2) + min2;
image(:,:,3) = image(:,:,3) * (max3 - min3) + min3;
for i = 1:w
    for j = 1:h      
        image(i,j,:) = Net_luv2rgb(image(i,j,:));
    end
end  
stri = [num2str(num),' OF:',num2str(obj)];
figure;
imshow(image);title(stri);


