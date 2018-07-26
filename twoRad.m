function [th] = twoRad(th1)
while(abs(th1)>=360)
    if th1>=360
        th1 = th1 - 360;
    elseif th1<=-360
        th1 = th1 + 360;
    end
end
th = th1;
end