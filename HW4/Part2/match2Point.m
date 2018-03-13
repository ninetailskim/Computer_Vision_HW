function matchpoint = match2Point(match,FX,FC)
    matchpoint = [];
    for i = 1:size(match,1)
        matchpoint = [matchpoint;FX(1,match(i,1)) FX(2,match(i,1)) FC(1,match(i,2)) FC(2,match(i,2))];
    end