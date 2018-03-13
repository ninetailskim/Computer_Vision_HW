function H = getH(p1,p2)
    A = [];
    iter = size(p1,1);
    for i = 1:iter
        A = [A;p2(i,:) 1 0 0 0 -p1(i,1) * p2(i,1) -p1(i,1) * p2(i,2) -p1(i,1)];
        A = [A;0 0 0 p2(i,:) 1 -p1(i,2) * p2(i,1) -p1(i,2) * p2(i,2) -p1(i,2)];
    end;
    
    ATA = A' * A;
    [VC,VA] = eig(ATA);
    [va,in] = min(ones(1,9) * VA);
    p = VC(:,in);
    p = p ./ p(9);
    
    H = [];
    for i = 1:3
        for j = 1:3
            H(i,j) = p((i - 1) * 3 + j);
        end;
    end;
    