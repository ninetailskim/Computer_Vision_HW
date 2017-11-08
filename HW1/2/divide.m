function [Inpor] = divide(imga,imgb,pic,histarg)
    ewidth = 360 / pic;
    hista = zeros(0,0);
    histb = zeros(0,0);
    for i = 1:pic
        for j = 1:pic
            tempa = getHist(imga((i - 1) * ewidth + 1:i * ewidth,(j - 1) * ewidth + 1:j * ewidth ) , histarg);
            hista = [hista,tempa];
            tempb = getHist(imgb((i - 1) * ewidth + 1:i * ewidth,(j - 1) * ewidth + 1:j * ewidth ), histarg);
            histb = [histb,tempb];   
        end;
    end;
    hista = hista / norm(hista);
    histb = histb / norm(histb);   
    Inpor = hista * histb';