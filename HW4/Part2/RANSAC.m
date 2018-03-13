function FH = RANSAC(scene,book,match,RANRT,FB,FS,a,b)
    [wb,lb,~] = size(book);
    [ws,ls,~] = size(scene);
    bg = uint8(zeros(5*wb,5*lb,3));
    bg(1+wb*2:3*wb,a:b,:) = book;
    bg(1+wb*2:3*wb,1+lb*2:3*lb,:) = scene;
    o2iinum = 0;
    imatch = [];
    o2imindex = [];
    omatch = [];
    fomatch = [];
    oindex = [];
    
    for i = 1:10000
        %K在?儿??定?
        [trainmatchP,testmatchP] = getrandmatch(match,FS,FB,4,a,wb,lb);
        H = getH(trainmatchP(:,3:4),trainmatchP(:,1:2));
        temptest = testmatchP(:,1:2);
        temptest(:,3) = 1;
        tempp = H * temptest';
        tempp(1,:) = tempp(1,:) ./ tempp(3,:);
        tempp(2,:) = tempp(2,:) ./ tempp(3,:);
        corp = testmatchP(:,3:4)';  
        dis = sqrt(sum((tempp(1:2,:) - corp) .^2));
%         a = a + mean(dis);
        index = find(dis < RANRT);
        if(size(index,2) > o2iinum)
            o2iinum = size(index,2);
            imatch = trainmatchP;
            o2imindex = index;
            omatch = testmatchP;
            oindex = find(dis >= RANRT);
        end
    end

%     a / 1000
    for j = 1:o2iinum
        imatch = [imatch;omatch(o2imindex(j),:)];
    end
    imatch = (round(imatch));
    for j = 1:size(oindex,2)
        fomatch = [fomatch;omatch(oindex(j),:)];
    end
    fomatch = (round(fomatch));
%     ?inline和outline
%     figure;
%     imshow(bg);
%     hold on;
%     for j = 1:size(imatch,1)
%          plot([imatch(j,1),imatch(j,3)],[imatch(j,2),imatch(j,4)],'-','LineWidth',1,'color',[1,0,0]);
%     end
% 
%     for j = 1:size(fomatch,1)
%          plot([fomatch(j,1),fomatch(j,3)],[fomatch(j,2),fomatch(j,4)],'-','LineWidth',1,'color',[0,1,0]);
%     end
    
    %最??算的H
    FH = getH(imatch(:,3:4),imatch(:,1:2));
    
    
    
    
    