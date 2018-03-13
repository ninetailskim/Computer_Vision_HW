function [] = RANSAC(scene,book,drt,RANRT,bookPoints)
    slscene = single(rgb2gray(scene));
    slbook = single(rgb2gray(book));
    [FS,DS] = vl_sift(slscene);
    [FB,DB] = vl_sift(slbook);
    [wb,lb,~] = size(book);
    [ws,ls,~] = size(scene);
    bg = getbg(book,scene,wb,lb,ws,ls);
    a = 0;
    match = getmatch(drt,DS,DB);
%     drawline(book,scene,FS,FB,match);
    o2iinum = 0;
    imatch = [];
    o2imindex = [];
    omatch = [];
    fomatch = [];
    oindex = [];
    for i = 1:10000
        %K在?儿??定?
        [trainmatchP,testmatchP] = getrandmatch(match,FS,FB,4);
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
    %?inline和outline
    figure;
    imshow(bg);
    hold on;
    for j = 1:size(imatch,1)
         plot([imatch(j,1),imatch(j,3)+ls],[imatch(j,2),imatch(j,4)],'-','LineWidth',1,'color',[1,0,0]);
    end
    size(imatch,1)
    for j = 1:size(fomatch,1)
         plot([fomatch(j,1),fomatch(j,3)+ls],[fomatch(j,2),fomatch(j,4)],'-','LineWidth',1,'color',[0,1,0]);
    end
    
    %最??算的H
    FH = getH(imatch(:,3:4),imatch(:,1:2));
    
    bp(:,1) = bookPoints(:,2);
    bp(:,2) = bookPoints(:,1);
    bp(:,3) = 1;
    sp = FH * bp';
    sp(1,:) = sp(1,:) ./ sp(3,:);
    sp(2,:) = sp(2,:) ./ sp(3,:);
    sp = round(sp);
    sp(1,:) = sp(1,:) + ls;
    
    figure;
    imshow(bg);
    hold on;
    plot([sp(1,1),sp(1,2)],[sp(2,1),sp(2,2)],'-','LineWidth',2,'color',[1,0,0]);
    plot([sp(1,1),sp(1,3)],[sp(2,1),sp(2,3)],'-','LineWidth',2,'color',[0,1,0]);
    plot([sp(1,2),sp(1,4)],[sp(2,2),sp(2,4)],'-','LineWidth',2,'color',[0,0,1]);
    plot([sp(1,3),sp(1,4)],[sp(2,3),sp(2,4)],'-','LineWidth',2,'color',[1,1,0]);
    plot([bookPoints(1,2),bookPoints(2,2)],[bookPoints(1,1),bookPoints(2,1)],'-','LineWidth',2,'color',[1,0,0]);
    plot([bookPoints(1,2),bookPoints(3,2)],[bookPoints(1,1),bookPoints(3,1)],'-','LineWidth',2,'color',[0,1,0]);
    plot([bookPoints(2,2),bookPoints(4,2)],[bookPoints(2,1),bookPoints(4,1)],'-','LineWidth',2,'color',[0,0,1]);
    plot([bookPoints(3,2),bookPoints(4,2)],[bookPoints(3,1),bookPoints(4,1)],'-','LineWidth',2,'color',[1,1,0]);
    
    tempin = imatch(:,1:2);
    tempin(:,3) = 1;
    inmatchP = FH * tempin';
    inmatchP(1,:) = inmatchP(1,:) ./ inmatchP(3,:);
    inmatchP(2,:) = inmatchP(2,:) ./ inmatchP(3,:);
    inmatchP = round(inmatchP);
    inmatchP(1,:) = inmatchP(1,:) + ls;
    figure;
    imshow(bg);
    hold on;
    for i =1:size(inmatchP,2)
        plot([inmatchP(1,i),imatch(i,3)+ls],[inmatchP(2,i),imatch(i,4)],'-','LineWidth',2,'color',[1,0,0]);
        plot(inmatchP(1,i),inmatchP(2,i),'-or');
        plot(imatch(i,3)+ls,imatch(i,4),'-og');
    end
    
    
    
    
    