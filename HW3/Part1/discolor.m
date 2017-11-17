function [res,images] = discolor(color,image,points,record,inpoints)
    [maxi,maxj,mini,minj,UP,DOWN] = getBound(inpoints);
    resPoint = [];
    for i = 0:1
        for j = 0:1
            resPoint = [resPoint;floor([points(1) + i,points(2) + j])];
        end;
    end;
    for k = 1:4
        pp = resPoint(k,:);
        if (pp(1) >= mini && pp(1) <= maxi && pp(2) > UP(pp(1) - mini + 1) && pp(2) < DOWN(pp(1) - mini + 1))
        else
            if(pp(1) <= 1068 & pp(1) >= 1 & pp(2) >= 1 & pp(2) <= 712)
                s =  abs(resPoint(5 - k,1) - points(1)) * abs(resPoint(5 - k,2) - points(2));
                image(pp(2),pp(1),:) = image(pp(2),pp(1),:) + color * s;
                record(pp(2),pp(1)) = record(pp(2),pp(1)) + s;
            end
        end
    end;
    res = record;
    images = image;
    
    
    
    
