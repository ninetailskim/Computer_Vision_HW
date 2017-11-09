function [K,R,t] = Part1B(P)
    M = P(:,1:3);
    T = P(:,4);

    [K,R] = getK(inv(M));
    t = inv(K) * T;
