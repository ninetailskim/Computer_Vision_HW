function [bound] = getBo(H,Points)
    Points(:,3) = 1;
    bound = H * Points';
    bound(1,:) = bound(1,:) ./ bound(3,:);
    bound(2,:) = bound(2,:) ./ bound(3,:);