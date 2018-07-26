function [newCoords] = arcCompute(Coords,Length)
backWheels = [Coords(1)-2*cosd(Coords(3));Coords(2)-2*sind(Coords(3))];
if Coords(4)>0
    L = 2/tand(Coords(4));
    irc = [backWheels(1)+L*cosd(Coords(3)+90);...
        backWheels(2)+L*sind(Coords(3)+90)];                               %Inst Rotation Centre
    %scatter(irc(1),irc(2),'b');
    R = norm([Coords(1)-irc(1);Coords(2)-irc(2)]);                         %Inst Rotation Radius
    theta = Length*360/(2*pi*R);
    newX = irc(1)-R*sind(-Coords(3)-Coords(4)-theta);
    newY = irc(2)-R*cosd(-Coords(3)-Coords(4)-theta);
    newCoords = [newX;newY;Coords(3)+theta];                               %New Coords
elseif Coords(4)<0
    L = 2/tand(Coords(4));
    irc = [backWheels(1)+L*cosd(Coords(3)+90);...
        backWheels(2)+L*sind(Coords(3)+90)];                               %Inst Rotation Centre
    %scatter(irc(1),irc(2),'b');
    R = norm([Coords(1)-irc(1);Coords(2)-irc(2)]);                         %Inst Rotation Radius
    theta = Length*360/(2*pi*R);
    newX = irc(1)-R*sind(Coords(3)+Coords(4)-theta);
    newY = irc(2)+R*cosd(Coords(3)+Coords(4)-theta);
    newCoords = [newX;newY;Coords(3)-theta];                               %New Coords 
elseif Coords(4)==0
    newCoords = [Coords(1)+Length*cosd(Coords(3));...
        Coords(1)+Length*sind(Coords(3));Coords(3)];
end
