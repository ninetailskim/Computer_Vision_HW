function [R,Q] = getK(M)
    xa = M(:,1);
    xb = M(:,2);
    xc = M(:,3);
    ya = xa;
    yb = xb - (ya'*xb/(ya'*ya))*ya;
    yc = xc - (ya'*xc/(ya'*ya))*ya - (yb'*xc/(yb'*yb))*yb;
    ya = ya / norm(ya);
    yb = yb / norm(yb);
    yc = yc / norm(yc);
    Q = [ya yb yc];
    R = [ya'*xa ya'*xb ya'*xc;0 yb'*xb yb'*xc;0 0 yc'*xc];
    Q = inv(Q);
    R = inv(R);
    %---Q?o¡A R?ut
    