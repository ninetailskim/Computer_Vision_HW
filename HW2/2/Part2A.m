load('P2Point.mat');
Points = floor(Points);
% test = Points(:,2);
% Points(:,2) = Points(:,1);
% Points(:,1) = test;
Pol = Points(1:4,:);
Por = Points(5:8,:);
H = [];

for i = 1:4
    H = [H;Pol(i,:) 1 0 0 0 -Por(i,1) * Pol(i,1) -Por(i,1) * Pol(i,2) -Por(i,1)];
    H = [H;0 0 0 Pol(i,:) 1 -Por(i,2) * Pol(i,1) -Por(i,2) * Pol(i,2) -Por(i,2)];
end;

HTH = H' * H;
[VC,VA] = eig(HTH);
[va,in] = min(ones(1,9) * VA);
p = VC(:,in);
%p = p / norm(p);
p = p ./ p(9);


P = [];
for i = 1:3
    for j = 1:3
        P(i,j) = p((i - 1) * 3 + j);
    end;
end;