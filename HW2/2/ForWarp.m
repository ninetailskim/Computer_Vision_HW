function [recor,image] = ForWarp(texture,image,H,inpoints,recor)
    [w,h] = size(rgb2gray(texture));
    %[maxi,maxj,mini,minj,UP,DOWN] = getBound(points);
    for i = 1:w
        for j = 1:h
            ori = H * [i j 1]';
            ori = ori';
            ori(1) = ori(1) / ori(3);
            ori(2) = ori(2) / ori(3);
            color = texture(j,i,:);
            point = ori(1:2);
            [recor,image] = discolor(color,image,point,recor,inpoints);
        end;
    end;
            
            
    