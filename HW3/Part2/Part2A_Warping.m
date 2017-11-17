clc;
clear;
%«e´º
video = VideoReader('jaguar.avi');
video.CurrentTime = 0.0;
H = round(video.Height);
W = round(video.Width);
Rate = video.FrameRate;
% mov(1:nFrames) = struct('cdata',zeros(H,W,3,'uint8'),'colormap',[]);
%­I´º
backvideo = VideoReader('midback.avi');
backvideo.CurrentTime = 0.0;
backH = round(backvideo.Height);
backW = round(backvideo.Width);
% mov2(1:backnFrames) = struct('cdata',zeros(backH,backW,3,'uint8'),'colormap',[]);
%?ªG
resObj = VideoWriter('Result_Warping.avi');
open(resObj);
%«e´º??

%read the first frame,get two classes;
P = readFrame(video);
P = im2double(P);
[tmeans,index] = kmeans(2,P);
suma = sum(sum(index == 1));
sumb = sum(sum(index == 2));
if(suma > sumb)
  means = tmeans(2,:);
  back = tmeans(1,:);
else
  means = tmeans(1,:);
  back = tmeans(2,:);
end
mepix = zeros(1,1,3);
bapix = zeros(1,1,3);
mepix(1,1,1) = means(1);
mepix(1,1,2) = means(2);
mepix(1,1,3) = means(3);
bapix(1,1,1) = back(1);
bapix(1,1,2) = back(2);
bapix(1,1,3) = back(3);
repmepix = repmat(mepix,[H,W]);
repbapix = repmat(bapix,[H,W]);
disp('get two class colors');

%Cal the Homo
Forepoint = [1 1;1 W;H 1;H W];
Backpoint = [1 1;1 backW;backH 1;backH backW];

Homo = calH(Backpoint,Forepoint);
disp('get Homo');


while hasFrame(video)  
    P = readFrame(video);
    P = im2double(P);
    if(hasFrame(backvideo))
        backP = readFrame(backvideo);
    else
        backvideo.CurrentTime = 0.0;
        backP = readFrame(backvideo);
    end 
    backP = im2double(backP);
    %imshow(backP);
    %find the cloest color
    dis = zeros(H,W,2); 
    jud = zeros(H,W,2);
    dis(:,:,1) = (P(:,:,1) - repmepix(:,:,1)) .^ 2 + (P(:,:,2) - repmepix(:,:,2)) .^ 2 + (P(:,:,3) - repmepix(:,:,3)) .^ 2;
    dis(:,:,2) = (P(:,:,1) - repbapix(:,:,1)) .^ 2 + (P(:,:,2) - repbapix(:,:,2)) .^ 2 + (P(:,:,3) - repbapix(:,:,3)) .^ 2;
    recor = zeros(backH,backW);
    [~,index] = min(dis,[],3);
    [meanx,meany] = find(index == 1);
    len = length(meanx);
    for j = 1:len
        ori = Homo * [meany(j),meanx(j),1]';
        ori = ori';
        ori(1) = ori(1) / ori(3);
        ori(2) = ori(2) / ori(3);
        color = P(meanx(j),meany(j),:);
        point = ori(1:2);
        [recor,backP] = discolor2(color,backP,point,recor);
    end
    for k = 1:backH
        for j = 1:backW
            if(recor(k,j) ~= 0)
                backP(k,j,:) = backP(k,j,:) / recor(k,j);
            end
        end
    end
%     aaa = 1;
%     figure;
%     imshow(backP);
    frame = backP;
    writeVideo(resObj,frame);
end
close(resObj);
    
    