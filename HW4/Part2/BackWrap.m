function new_color = BackWrap(A,oriPoint)
    [w,l,~] = size(A);
    resPoint = [];
    for i = 0:1
        for j = 0:1
            resPoint = [resPoint;floor([oriPoint(1) + i,oriPoint(2) + j])];
        end;
    end;
    new_color = uint8(zeros(1,1,3));
    for k = 1:4
        if(resPoint(k,2) > 0 && resPoint(k,2) <= l && resPoint(k,1) > 0 && resPoint(k,1) <= w)
            new_color = new_color + A(resPoint(k,2),resPoint(k,1),:) * (abs(resPoint(5-k,1) - oriPoint(1)) * abs(resPoint(5-k,2) - oriPoint(2)));
        end
    end;