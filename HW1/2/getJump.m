%計算跳變次數
function [jumpCount] = getJump(i)
    a = zeros(1,8);
    jumpCount = 0;
    k = 1;
    while i > 0
        a(k) = mod(i,2);
        i = floor(i/2);
        k = k + 1;
    end;
    for j = 1:7
        if a(j)~=a(j+1)
            jumpCount = jumpCount + 1;
        end;
    end;
    if a(1)~=a(8)
        jumpCount = jumpCount + 1;
    end;
end