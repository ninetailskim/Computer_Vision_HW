A = imread('debate.jpg');

A(100:200,200:300,:) = 0;
imshow(A);

% a = [1 2 3 4 5; 7 8 9 0 9;2 5 8 3 6;1 34 7 3 9];
% 
% [n,m] = find(a == 1);
% n
% m