function bg = getbg(book,scene,wb,lb,ws,ls)
    bgbook = book;
    bgbook(wb+1:ws,1:2*ls,:) = 0;
    bgbook(1:ws,lb+1:2*ls,:) = 0;
    bgscene = repmat(scene,[1,2]);
    bgscene(1:ws,1:ls,:) = 0;
    bg = bgbook + bgscene;