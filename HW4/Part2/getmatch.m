function match = getmatch(drt,DS,DB)
    match = [];
    [~,lb] = size(DB);
    [~,ls] = size(DS);
    flag = 0;
    DS=double(DS);
    DB=double(DB);
    for i=1:lb
        tDB = repmat(DB(:,i),[1,ls]);
        dis = sqrt(sum((tDB - DS) .^ 2));
        [min1,index1] = min(dis);
        dis(index1) = Inf;
        [min2,~] = min(dis);
        %using to find the DRT
        if(min2-min1 > drt * min1)
            if(flag)
                if(sum(match(:,2) == index1))
                    sameindex = find(match(:,2) == index1);
                    if(match(sameindex,3) > min1)
                        match(sameindex,:) = [];
                        match = [match;i index1 min1];
                    end
                else
                    match = [match;i index1 min1];
                    flag = flag + 1;
                end
            else
                match = [match;i index1 min1];
                flag = flag + 1;
            end
        end

%         tDB = repmat(DB(:,i),[1,ls]);
%         dis = sqrt(sum((tDB - DS) .^ 2));
%         [min1,index1] = min(dis);
%         match = [match;i index1];
    end