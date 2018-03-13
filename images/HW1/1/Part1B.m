clear;
load('Part1AData.mat');
str1 = 'kernel3';
str2 = 'kernel5';
mag3 = drawMag(B3,str1);
mag5 = drawMag(B5,str2);

drawDir(B3,mag3,str1);
drawDir(B5,mag5,str2);