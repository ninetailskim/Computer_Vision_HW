function res = getKrandnums(k,width,length)
%     res = randint(1,k,[1,width]);
%     res = [res;randint(1,k,[1,length])];
    res = randi(width,1,k);
    res = [res;randi(length,1,k)];