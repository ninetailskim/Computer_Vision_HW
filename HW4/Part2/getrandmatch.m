function [randmatchP,testmatchP] = getrandmatch(match,FS,FB,K,a,wb,lb)

    randomindex = randperm(size(match,1));

    randmatchP = [];
    testmatchP = [];
    
    for i= 1:K
        randmatchP = [randmatchP;FB(1,match(randomindex(i),1))+a-1 FB(2,match(randomindex(i),1))+2*wb FS(1,match(randomindex(i),2))+2*lb FS(2,match(randomindex(i),2))+2*wb];
    end
    for i= K+1:size(match,1)
        testmatchP = [testmatchP;FB(1,match(randomindex(i),1))+a-1 FB(2,match(randomindex(i),1))+2*wb FS(1,match(randomindex(i),2))+2*lb FS(2,match(randomindex(i),2))+2*wb];
    end