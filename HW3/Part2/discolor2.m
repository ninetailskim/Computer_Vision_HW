function [res,images] = discolor2(color,image,points,record)
    [width,height,~] = size(image);
    resPoint = [];
    for i = 0:1
        for j = 0:1
            resPoint = [resPoint;floor([points(1) + i,points(2) + j])];
        end;
    end;
    for k = 1:4
        pp = resPoint(k,:);
        if(pp(2) < 1 || pp(1) < 1 || pp(1) > height || pp(2) > width)
        else    
            if(record(pp(2),pp(1)) == 0)
                image(pp(2),pp(1),:) = 0;
            end
            s =  abs(resPoint(5 - k,1) - points(1)) * abs(resPoint(5 - k,2) - points(2));
            image(pp(2),pp(1),:) = image(pp(2),pp(1),:) + color * s;
            record(pp(2),pp(1)) = record(pp(2),pp(1)) + s;
        end
    end;
    res = record;
    images = image;