clear;
clc;
A = imread('AmumuPoro.jpg');

[width,height,~] = size(A); 
% B = imresize(A,0.3);
B = A;
figure;
imshow(B);

[w,h,~] = size(B);
B = im2double(B);
res = B;
visited = zeros(w,h);

meankind = 800;

dis = zeros(w,h,meankind);
index = zeros(w,h,meankind);
father = zeros(1,meankind);

for i = 1:meankind
    father(i) = i;
end

kind = 1;
allmean = zeros(meankind,1,3);

bandwidth = 0.08;

pixshift = zeros(1,1,3);
for i = 1:w
    for j = 1:h
        if visited(i,j) == 0
            mean = B(i,j,:);
            flag = true;
            while (flag)
                temp = repmat(mean,[w,h]);
                %distance
                dis(:,:,kind) = (temp(:,:,1) - B(:,:,1)) .^ 2 + (temp(:,:,2) - B(:,:,2)) .^ 2 + (temp(:,:,3) - B(:,:,3)) .^ 2;
                dis(:,:,kind) = sqrt(dis(:,:,kind));
                %<bandwidth index (0/1)
                inbw = dis(:,:,kind) < bandwidth;
                %count of this point
                index(:,:,kind) = index(:,:,kind) + inbw;
                %mark if visited
                visited = visited|index(:,:,kind);
                
                %cal the shift
                suminbw = sum(sum(inbw));
                pixshift(1,1,1) = sum(sum(inbw .* (B(:,:,1) - temp(:,:,1)))) / suminbw;
                pixshift(1,1,2) = sum(sum(inbw .* (B(:,:,2) - temp(:,:,2)))) / suminbw;
                pixshift(1,1,3) = sum(sum(inbw .* (B(:,:,3) - temp(:,:,3)))) / suminbw;
                mean2 = mean + pixshift;
                gap = sqrt((mean2(1,1,1) - mean(1,1,1)) ^2 + (mean2(1,1,2) - mean(1,1,2)) ^2 + (mean2(1,1,3) - mean(1,1,3)) ^2);
                if(gap < 0.002)
                    flag = false;
                else
                    mean = mean2;
                end
            end
            allmean(kind,:,:) = mean;
            if(kind >= 2)
                for same = 1:kind - 1
                    m1 = allmean(same,1,:);
                    gap = sqrt((m1(1,1,1) - mean(1,1,1)) ^2 + (m1(1,1,2) - mean(1,1,2)) ^2 + (m1(1,1,3) - mean(1,1,3)) ^2);
                    if(gap < 0.01)
                        index(:,:,same) = index(:,:,same) + index(:,:,kind);
                        index(:,:,kind) = 0;
                        father(kind) = same;
                        allmean(kind,:,:) = allmean(same,:,:);
                        disp('lalala');
                        break;  
                    end
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
figure;
SCA = reshape(B,[],3);
% c = 
scatter3(SCA(:,1),SCA(:,2),SCA(:,3),1,SCA);
figure;
SCAR = reshape(res,[],3);
scatter3(SCAR(:,1),SCAR(:,2),SCAR(:,3),1,SCAR);