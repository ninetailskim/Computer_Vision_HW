load('board1point.mat');
load('board2point.mat');

A = [];
B = [];
for i = 1:108
    A = [A;Ap3D(i,:) 1 0 0 0 0 -Ap3D(i,1)*Ap2D(i,1) -Ap3D(i,2)*Ap2D(i,1) -Ap3D(i,3)*Ap2D(i,1) -Ap2D(i,1)];
    A = [A;0 0 0 0 Ap3D(i,:) 1 -Ap3D(i,1)*Ap2D(i,2) -Ap3D(i,2)*Ap2D(i,2) -Ap3D(i,3)*Ap2D(i,2) -Ap2D(i,2)];
    B = [B;Bp3D(i,:) 1 0 0 0 0 -Bp3D(i,1)*Bp2D(i,1) -Bp3D(i,2)*Bp2D(i,1) -Bp3D(i,3)*Bp2D(i,1) -Bp2D(i,1)];
    B = [B;0 0 0 0 Bp3D(i,:) 1 -Bp3D(i,1)*Bp2D(i,2) -Bp3D(i,2)*Bp2D(i,2) -Bp3D(i,3)*Bp2D(i,2) -Bp2D(i,2)];
end;

ATA = A' * A;
[AVC,AVA] = eig(ATA);
[va,Ain] = min(ones(1,12) * AVA);
Ap = AVC(:,Ain);
Ap = Ap / norm(Ap);

BTB = B' * B;
[BVC,BVA] = eig(BTB);
[va,Bin] = min(ones(1,12) * BVA);
Bp = BVC(:,Bin);
Bp = Bp / norm(Bp);

AP = [];
BP = [];
for i = 1:3
    for j = 1:4
        AP(i,j) = Ap((i - 1) * 4 + j);
        BP(i,j) = Bp((i - 1) * 4 + j);
    end;
end;
%-----------------b-----------------
[AK,AR,At] = Part1B(AP);
[BK,BR,Bt] = Part1B(BP);
%-----------------c------------------
Part1C(AK,AR,At,Ap3D,Ap2D,'chessboard1.jpg');
Part1C(BK,BR,Bt,Bp3D,Bp2D,'chessboard2.jpg');

%-----------------------d---------------------
visualizeCamera(Ap3D,AR,At,BR,Bt);

