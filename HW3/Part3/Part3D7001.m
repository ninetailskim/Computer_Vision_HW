clear;
clc;
A = imread('AmumuPoro.jpg');

[width,height,~] = size(A); 
% B = imresize(A,0.3);
B = A;
figure;
imshow(B);
%50-70
spacew = 70;

[w,h,~] = size(B);
B = im2double(B);
res = B;
visited = zeros(w,h);

meankind = 1500;

dis = zeros(w,h,meankind);
index = zeros(w,h,meankind);
father = zeros(1,meankind);

kind = 1;
allmean = zeros(meankind,1,3);
%0.15-0.1
bandwidth = 0.1;

pixshift = zeros(1,1,3);
for i = 1:w
    for j = 1:h
        if visited(i,j) == 0
            mean = B(i,j,:);
            meanxy = [i j];
            flag = true;
            while (flag)
                temp = repmat(mean,[w,h]);
                %distance
                dis(:,:,kind) = (temp(:,:,1) - B(:,:,1)) .^ 2 + (temp(:,:,2) - B(:,:,2)) .^ 2 + (temp(:,:,3) - B(:,:,3)) .^ 2;
                dis(:,:,kind) = sqrt(dis(:,:,kind));
                %<bandwidth index (0/1)
                inbw = dis(:,:,kind) < bandwidth;
                filter = zeros(w,h);
                for si = -spacew:spacew
                    for sj = -spacew:spacew
                        if(meanxy(1) + si > 0 && meanxy(1) + si <= w && meanxy(2) + sj >0 && meanxy(2) + sj <= h)
                            filter(meanxy(1) + si,meanxy(2) + sj) = 1;
                        end
                    end
                end
                inbw = inbw&filter;
                
                %count of this point
                index(:,:,kind) = index(:,:,kind) + inbw;
                %mark if visited
                visited = visited|index(:,:,kind);                
                
                %cal the space shift
                [meanx,meany] = find(inbw == 1);
                
                
                %cal the RGB shift
                suminbw = sum(sum(inbw));
                sumx = sum(meanx) / suminbw;
                sumy = sum(meany) / suminbw;
                pixshift(1,1,1) = sum(sum(inbw .* (B(:,:,1) - temp(:,:,1)))) / suminbw;
                pixshift(1,1,2) = sum(sum(inbw .* (B(:,:,2) - temp(:,:,2)))) / suminbw;
                pixshift(1,1,3) = sum(sum(inbw .* (B(:,:,3) - temp(:,:,3)))) / suminbw;
                
                mean2 = mean + pixshift;
                meanxy = [round(sumx) round(sumy)];
                gap = sqrt((mean2(1,1,1) - mean(1,1,1)) ^2 + (mean2(1,1,2) - mean(1,1,2)) ^2 + (mean2(1,1,3) - mean(1,1,3)) ^2);
                if(gap < 0.002)
                    flag = false;
                else
                    mean = mean2;
                end
            end
            allmean(kind,:,:) = mean;
            if(kind >= 2)
                temin = kind;
                temmin = 3;
                for same = 1:kind - 1              
                    m1 = allmean(same,1,:);
                    gap = sqrt((m1(1,1,1) - mean(1,1,1)) ^2 + (m1(1,1,2) - mean(1,1,2)) ^2 + (m1(1,1,3) - mean(1,1,3)) ^2);
                    if(gap < temmin)
                        temmin = gap;
                        temin = same;
                    end
                end
                if(temmin < 0.15)
                    index(:,:,temin) = index(:,:,temin) + index(:,:,kind);
                    index(:,:,kind) = 0;
                    father(kind) = temin;
                    allmean(kind,:,:) = allmean(temin,:,:);
                    kind
                end
            end
            kind = kind + 1;
        end
    end
end

 [maxind,index2] = max(index,[],3);
 
for k = 1:w
    for l = 1:h
        res(k,l,:) = allmean(index2(k,l),1,:);
    end
end
kind
figure;
imshow(res);