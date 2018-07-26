clc; clear all; close all force; 
Tsampling = 0.0001;                               %/*sampling period*/
% myCar(7,5,-35,0);
% myCar(1,-2,45,0);
% axis equal; grid on; grid minor;
% x=[arcCompute([7,5,-35,-35],0.5);-35];
% myCar(x(1),x(2),x(3),x(4));
% axis equal;
%  x1 = []; x2 = []; x3 = [];
% for i = 0:1:22
%     x=[arcCompute([7,5,-35,-35],i);-35];
%     myCar(x(1),x(2),x(3),x(4));
%     axis equal;
%     pause(0.01);
%     x1 = [x1 x(1)];
%     x2 = [x2 x(2)];
%     x3 = [x3 x(3)];
% end
%% inputs
prompt = {'Enter x desired coordinate:','Enter y desired coordinate:','Enter desired angle:',...
    'Enter x initial coordinate:','Enter y initial coordinate:','Enter initial angle:'};
dlg_title = 'Algorithm Inputs';
num_lines = 1;
defaultans = {'10','10','45','0','0','90'};
answer = str2double(inputdlg(prompt,dlg_title,num_lines,defaultans));
initCoords = answer(4:6);
desiredCoords = answer(1:3);
%% plane position inspection algorithm
ka = 2 ; kb = -13 ; kr = 2;
l2plot = 3.1;
instantCoords = initCoords(1:3);
x1 = []; x2 = []; x3 = []; vp = []; gp = [];
while sum(abs(instantCoords(1:2)-desiredCoords(1:2)))>0.001
    
    dx = -desiredCoords(1)+instantCoords(1);
    dy = -desiredCoords(2)+instantCoords(2);
    r = sqrt(dx^2+dy^2);
    a = twoRad(atand(dy/dx)-twoRad(instantCoords(3)));
    b = twoRad(-instantCoords(3)-a+desiredCoords(3));
    v = kr*r;
    g = twoRad(ka*a+kb*b);
    if g>40
        g = 40;
    elseif g < -40
        g = -40;
    end
    if v > 30/3.6
        v = 30/3.6;
    end
    if l2plot > 1.5
        myCar(instantCoords(1),instantCoords(2),instantCoords(3),g);
        l2plot = 0;
    end
    instantCoords = arcCompute([instantCoords(1);instantCoords(2);...
        instantCoords(3);g],v*Tsampling)
    instantCoords(3) = twoRad(instantCoords(3));
    l2plot = l2plot + abs(v*Tsampling);
    x1 = [x1 instantCoords(1)];
    x2 = [x2 instantCoords(2)];
    x3 = [x3 instantCoords(3)];
    vp = [vp v];
    gp = [gp g];
end
myCar(instantCoords(1),instantCoords(2),instantCoords(3),g);
axis equal; grid on; grid minor;