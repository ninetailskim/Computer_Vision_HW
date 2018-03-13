function res = drawline(book,scene,matchcor)
   [wb,lb,~] = size(book);
   [ws,ls,~] = size(scene);
   bg = getbg(book,scene,wb,lb,ws,ls);
   figure;
   imshow(bg);
   hold on;
   for i = 1:size(matchcor,1)
        plot([matchcor(i,1),matchcor(i,3)+ls],[matchcor(i,2),matchcor(i,4)],'-','LineWidth',1,'color',[0,1,0]);
        plot(matchcor(i,1),matchcor(i,2),'-og');
        plot(matchcor(i,3)+ls,matchcor(i,4),'-og');
   end
   
   
   