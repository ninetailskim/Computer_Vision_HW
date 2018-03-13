function res = drawline(book,scene,FS,FB,match)
   [wb,lb,~] = size(book);
   [ws,ls,~] = size(scene);
   bg = getbg(book,scene,wb,lb,ws,ls);
   matchcor = [];
   [l,~] = size(match);
   for i = 1:l
        matchcor = [matchcor;round(FB(1,match(i,1))) round(FB(2,match(i,1))) round(FS(1,match(i,2))+ls) round(FS(2,match(i,2)))];
%         matchcor = [matchcor;FB(1,match(i,1)) FB(2,match(i,1)) FS(1,match(i,2)) FS(2,match(i,2))+ls];
   end
   matchcor = int32(matchcor);
   figure;
   imshow(bg);
   hold on;
   for i = 1:size(matchcor,1)
        plot([matchcor(i,1),matchcor(i,3)],[matchcor(i,2),matchcor(i,4)],'-','LineWidth',1,'color',[0,1,0]);
        plot(matchcor(i,1),matchcor(i,2),'-og');
        plot(matchcor(i,3),matchcor(i,4),'-og');
   end
   
   
   