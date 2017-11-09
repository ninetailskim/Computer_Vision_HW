load('H.mat');

A = imread('debate.jpg');
B = A;

mini = min(Por(1,1),Por(3,1));
maxi = max(Por(2,1),Por(4,1));
maxj = Por(4,2);
minj = Por(2,2);

upP = (Por(2,2) - Por(1,2)) / (Por(2,1) - Por(1,1));
downP = (Por(4,2) - Por(3,2)) / (Por(4,1) - Por(3,1));

temp = 1:maxi - mini + 1;
UP = round(temp * upP + Por(1,2));
DOWN = round(temp * downP + Por(3,2));

for i = mini:maxi
    for j = minj:maxj
        if (j > UP(i - mini + 1) & j < DOWN(i - mini + 1))
            ori = inv(P) * [i j 1]';
            ori = ori';
            ori(1) = ori(1) / ori(3);
            ori(2) = ori(2) / ori(3);
            B(j,i,:) = BackWrap(A,ori(1:2));
        end;
    end;
end;

figure;
imshow(B);

mini = min(Pol(1,1),Pol(3,1));
maxi = max(Pol(2,1),Pol(4,1));
maxj = Pol(3,2);
minj = Pol(1,2);

upP = (Pol(2,2) - Pol(1,2)) / (Pol(2,1) - Pol(1,1));
downP = (Pol(4,2) - Pol(3,2)) / (Pol(4,1) - Pol(3,1));

temp = mini:1:maxi;
UP = round((temp(:) - mini) * upP + Pol(1,2));
DOWN = round((temp(:) - mini) * downP + Pol(3,2));

for i = mini:maxi
    for j = minj:maxj
        if (j > UP(i - mini + 1) & j < DOWN(i - mini + 1))
            ori = P * [i j 1]';
            ori = ori';
            ori(1) = ori(1) / ori(3);
            ori(2) = ori(2) / ori(3);
            B(j,i,:) = BackWrap(A,ori(1:2));
        end;
    end;
end;

figure;
imshow(B);
