clc;
clear;
%前景
video = VideoReader('jaguar.avi');
video.CurrentTime = 0.0;
H = round(video.Height);
W = round(video.Width);
Rate = video.FrameRate;
% mov(1:nFrames) = struct('cdata',zeros(H,W,3,'uint8'),'colormap',[]);
%背景
backvideo = VideoReader('midback.avi');
backvideo.CurrentTime = 0.0;
backH = round(backvideo.Height);
backW = round(backvideo.Width);
% mov2(1:backnFrames) = struct('cdata',zeros(backH,backW,3,'uint8'),'colormap',[]);
%?果
resObj = VideoWriter('Result_Mask.avi');
open(resObj);
%前景??

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
    backP = backP(:,79:798,:);
    %find the cloest color
    %1是for 2是back
    dis = zeros(H,W,2); 
    jud = zeros(H,W,2);
    dis(:,:,1) = (P(:,:,1) - repmepix(:,:,1)) .^ 2 + (P(:,:,2) - repmepix(:,:,2)) .^ 2 + (P(:,:,3) - repmepix(:,:,3)) .^ 2;
    dis(:,:,2) = (P(:,:,1) - repbapix(:,:,1)) .^ 2 + (P(:,:,2) - repbapix(:,:,2)) .^ 2 + (P(:,:,3) - repbapix(:,:,3)) .^ 2;
    jud(:,:,1) = jud(:,:,1) + 1;
    jud(:,:,2) = jud(:,:,2) + 2;
    [mindis,index] = min(dis,[],3);
    repindex = repmat(index,[1,1,2]);
    indexfloor = repindex == jud;
    %for
    forimage = repmat(indexfloor(:,:,1),[1,1,3]) .* P;
    %back
    backimage = repmat(indexfloor(:,:,2),[1,1,3]) .* backP;
    resimage = forimage + backimage;
    frame = resimage;
    writeVideo(resObj,frame);
end
close(resObj);
disp('Finish!');
    
    