A = imread('texture.jpg');
load('B.mat');
load('P2Data.mat');
load('H.mat');
A = imresize(A,4);
A = im2double(A);
C = B;
C = im2double(C);
[w,h] = size(rgb2gray(B));
[tw,th] = size(rgb2gray(A));
LeftPoint = round(P3Data(1:4,:));
RightPoint = round(P3Data(5:8,:));
plane = [1,1;tw,1;1,tw;tw,th];

recor = zeros(w,h);

LH = calH(LeftPoint,plane);
RH = calH(RightPoint,plane);

%----deal with image
[lbxi,lbxj,lbni,lbnj,lbUP,lbDOWN] = getBound(LeftPoint);
[ilbxi,ilbxj,ilbni,ilbnj,ilbUP,ilbDOWN] = getBound(Pol);
[rbxi,rbxj,rbni,rbnj,rbUP,rbDOWN] = getBound(RightPoint);
[irbxi,irbxj,irbni,irbnj,irbUP,irbDOWN] = getBound(Por);



for i = lbni:lbxi
    for j = lbnj:lbxj
        if(j > lbUP(i - lbni + 1) & j < lbDOWN(i - lbni + 1))
            if (i >= ilbni && i <= ilbxi && j > ilbUP(i - ilbni + 1) && j < ilbDOWN(i - ilbni + 1))
            else
                C(j,i,:) = 0;
            end
        end
    end
end

for i = rbni:rbxi
    for j = rbnj:rbxj
        if(j > rbUP(i - rbni + 1) & j < rbDOWN(i - rbni + 1))
            if (i >= irbni && i <= irbxi && j > irbUP(i - irbni + 1) && j < irbDOWN(i - irbni + 1))
            else
                C(j,i,:) = 0;
            end
        end
    end
end
% figure;            
% imshow(C);

[recor,C] = ForWarp(A,C,LH,Pol,recor);
[recor,C] = ForWarp(A,C,RH,Por,recor);

recor = recor + 0.0000000000001;

for i = lbni:lbxi
    for j = lbnj:lbxj
        if(j > lbUP(i - lbni + 1) & j < lbDOWN(i - lbni + 1))
            if (i >= ilbni && i <= ilbxi && j > ilbUP(i - ilbni + 1) && j < ilbDOWN(i - ilbni + 1))
            else
                if C(j,i,:) == 0
                    C(j,i,:) = 255;
                else
                    C(j,i,:) = C(j,i,:) / recor(j,i);
                end;
            end
        end
    end
end

for i = rbni:rbxi
    for j = rbnj:rbxj
        if(j > rbUP(i - rbni + 1) & j < rbDOWN(i - rbni + 1))
            if (i >= irbni && i <= irbxi && j > irbUP(i - irbni + 1) && j < irbDOWN(i - irbni + 1))
            else
                if C(j,i,:) == 0
                    C(j,i,:) = 255;
                else
                    C(j,i,:) = C(j,i,:) / recor(j,i);
                end;
            end
        end
    end
end
figure;
imshow(C);