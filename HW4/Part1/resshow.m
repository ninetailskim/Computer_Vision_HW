function [] = resshow(book,scene,drt)

    slscene = single(rgb2gray(scene));
    slbook = single(rgb2gray(book));
%format [X;Y;S;TH], where X,Y is the (fractional) center of the frame, S is the scale and TH is the orientation (in radians). 
%Each column of D is the descriptor of the corresponding frame in F. A descriptor is a 128-dimensional vector of class UINT8. 
    [FS,DS] = vl_sift(slscene);
    [FB,DB] = vl_sift(slbook);

    %book1-------0.05
    %book2-------0.6
    %book3-------0.27
    match = getmatch(drt,DS,DB);
    drawline(book,scene,FS,FB,match)