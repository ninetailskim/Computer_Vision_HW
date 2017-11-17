function [tempmean,tempIndex] = kmeans(num,A3)
    [width,length,~] = size(A3);
    finalImage = A3;
    tempIndex = [];
    objective = inf;
    for gauss = 1:50
        clusters = getKrandnums(num,width,length);
        %generate K center and turn to RGB
        means1 = [];
        for j = 1:num
            p = A3(clusters(1,j),clusters(2,j),:);
            means1 = [means1;p(:,:,1) p(:,:,2) p(:,:,3)];
        end
        %converge flag
        flag = true;
        iter = 1;
        dis = zeros(width,length,num);
        while (iter < 35 && flag)
           %means2 = ones(num);
           counts = zeros(num,3);
           pix = zeros(1,1,3);  
           jud = zeros(width,length,num);
           for i = 1:num
               pix(1,1,1) = means1(i,1);
               pix(1,1,2) = means1(i,2);
               pix(1,1,3) = means1(i,3);
               temp = repmat(pix,[width,length]);
               dis(:,:,i) = (A3(:,:,1) - temp(:,:,1)) .^ 2 + (A3(:,:,2) - temp(:,:,2)) .^ 2 + (A3(:,:,3) - temp(:,:,3)) .^ 2;
               dis(:,:,i) = sqrt(dis(:,:,i));
               jud(:,:,i) = jud(:,:,i) + i;
           end
           [mindis,index] = min(dis,[],3);
           repindex = repmat(index,[1,1,num]);
           indexfloor = repindex == jud;
           colorr = repmat(A3(:,:,1),[1,1,num]) .* indexfloor;
           colorg = repmat(A3(:,:,2),[1,1,num]) .* indexfloor;
           colorb = repmat(A3(:,:,3),[1,1,num]) .* indexfloor;
           means3 = zeros(num,3);
           tr = sum(sum(colorr));
           tg = sum(sum(colorg));
           tb = sum(sum(colorb));
           c = sum(sum(indexfloor));
           tr = tr ./ c;
           tg = tg ./ c;
           tb = tb ./ c;
           for i = 1:num
              means3(i,1) = tr(i);
              means3(i,2) = tg(i);
              means3(i,3) = tb(i);    
           end
           
           res = sqrt(sum(sum((means3 - means1) .^ 2)));
           %judge converge
           if res < 0.005
               flag = false;
           end
           means1 = means3;
           iter = iter + 1;
        end
        %cal objective function
        tempobjective = sum(sum(sum(repmat(mindis,[1,1,num]) .* indexfloor)));
        if(tempobjective < objective)
            objective = tempobjective;
            tempIndex = index;
            tempmean = means3;
        end
    end
    %?可以再优化~
    for i = 1:width
          for j = 1:length
              in = tempIndex(i,j);
              finalImage(i,j,1) = tempmean(in,1);
              finalImage(i,j,2) = tempmean(in,2);
              finalImage(i,j,3) = tempmean(in,3);
          end
    end
%     figure;
%     imshow(finalImage);