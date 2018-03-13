clear
load('p1.mat');

[wl,ll,~] = size(left);
[wr,lr,~] = size(right);

HLC = RANSAC(center,left,matchLC,5,FL,FC,ll+1,2*ll);
HRC = RANSAC(center,right,matchRC,5,FR,FC,3*ll+1,4*ll);

OLP = [ll+1 2*wl+1;2*ll 2*wl+1;2*ll 3*wl;ll+1 3*wl];
ORP = [3*ll+1 2*wl+1;4*ll 2*wl+1;4*ll 3*wl;3*ll+1 3*wl];
OCP = [2*ll+1 2*wl+1;3*ll 2*wl+1;3*ll 3*wl;2*ll+1 3*wl;2*ll+1 2*wl+1];

LBoPo = getBo(HLC,OLP);
RBoPo = getBo(HRC,ORP);

bg = uint8(zeros(5*wl,5*ll,3));
% bg2 = bg;
bg(1+wl*2:3*wl,1+ll*2:3*ll,:) = center;
bg2 = bg;
% figure;
% imshow(bg);
bg(1+wl*2:3*wl,1+ll:ll*2,:) = left;
bg(1+wl*2:3*wl,3*ll+1:4*ll,:) = right;
% figure;
% imshow(bg);

[bgw,bgl,~] = size(bg);

lx = [LBoPo(1,:) LBoPo(1,1)];
ly = [LBoPo(2,:) LBoPo(2,1)];
rx = [RBoPo(1,:) RBoPo(1,1)];
ry = [RBoPo(2,:) RBoPo(2,1)];
cx = [OCP(:,1)]';
cy = [OCP(:,2)]';


Lmask = poly2mask(lx,ly,bgw,bgl);
Rmask = poly2mask(rx,ry,bgw,bgl);
Cmask = poly2mask(cx,cy,bgw,bgl);

[LY,LX] = find(Lmask~=0);
[RY,RX] = find(Rmask~=0);
[CY,CX] = find(Cmask~=0);


for i = 1:size(LX,1)
    x = LX(i);
    y = LY(i);
    ori = inv(HLC) * [x y 1]';
    ori = ori';
    ori(1) = ori(1) / ori(3);
    ori(2) = ori(2) / ori(3);
    color = uint8(BackWrap(bg,ori(1:2)));
    if(Cmask(y,x)~=1)
        bg2(y,x,:) = color;
    else
        bg2(y,x,:) = 0.5*color+0.5*bg2(y,x,:);
    end
%     bg2(y,x,:) = color+bg2(y,x,:);
end

for i = 1:size(RX,1)
    x = RX(i);
    y = RY(i);
    ori = inv(HRC) * [x y 1]';
    ori = ori';
    ori(1) = ori(1) / ori(3);
    ori(2) = ori(2) / ori(3);
%     bg2(y,x,:) = uint8(BackWrap(bg,ori(1:2)));
    color = uint8(BackWrap(bg,ori(1:2)));
    if(Cmask(y,x)~=1)
        bg2(y,x,:) = color;
    else
        bg2(y,x,:) = 0.5*color+0.5*bg2(y,x,:);
    end
%       bg2(y,x,:) = color+bg2(y,x,:);
end

minx = min(LX);
miny = min([LY' RY']);
maxx = max(RX);
maxy = max([LY' RY']);

figure;
imshow(bg2(miny:maxy,minx:maxx,:));

% for i = 1:size(CX,1)
%     x = CX(i);
%     y = CY(i);
%     bg2(y,x,:) = bg(y,x,:);
% end
% 
% 
% 
% 
% figure;
% imshow(bg2(miny:maxy,minx:maxx,:));
% Dmask = Lmask&Rmask&Cmask;
% 
% imshow(bg2);