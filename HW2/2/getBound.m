function [maxi,maxj,mini,minj,UP,DOWN] = getBound(points)
    maxi = max(points(2,1),points(4,1));
    mini = min(points(1,1),points(3,1));
    maxj = max(points(3,2),points(4,2));
    minj = min(points(1,2),points(2,2));
    
    upP = (points(2,2) - points(1,2)) / (points(2,1) - points(1,1));
    downP = (points(4,2) - points(3,2)) / (points(4,1) - points(3,1));
    
    index = 1:maxi - mini + 1;
    UP = round(index * upP + points(1,2));
    DOWN = round(index * downP + points(3,2));
    
    
    