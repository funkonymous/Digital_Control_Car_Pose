clc; clear all; close all force; 
Tsampling = 0.001;  
%% inputs
prompt = {'Enter x desired coordinate:',...
    'Enter y desired coordinate:',...
    'Enter desired angle:',...
    'Enter x initial coordinate:',...
    'Enter y initial coordinate:','Enter initial angle:'};
dlg_title = 'Algorithm Inputs';
num_lines = 1;
defaultans = {'10','10','45','0','0','90'};
answer = str2double(inputdlg(prompt,dlg_title,...
    num_lines,defaultans));
initCoords = answer(4:6);
desiredCoords = answer(1:3);
%% plane position inspection algorithm
ka = 2 ; kb = -13 ; kr = 2;
l2plot = 3.1;
instantCoords = initCoords(1:3);
x1 = []; x2 = []; x3 = []; vp = []; gp = []; vp1 = [];
Uprev = [0 0 0 0]; Yprev = [0 0 0 0];
WeightsU = [0.04001 -0.03997 -0.03998 0.03994];
WeightsY = [1.9346 0.06395822 -1.9346 0.93604178];
while sum(abs(instantCoords(1:2)-desiredCoords(2:2)))>0.001
    dx = -desiredCoords(1)+instantCoords(1);
    dy = -desiredCoords(2)+instantCoords(2);
    r = sqrt(dx^2+dy^2);
    a = twoRad(atand(dy/dx)-twoRad(instantCoords(3)));
    b = twoRad(-instantCoords(3)-a+desiredCoords(3));
    v1 = kr*r;
    g = twoRad(ka*a+kb*b);
    v = Uprev*WeightsU'+Yprev*WeightsY';
    Uprev(2:4) = Uprev(1:3);
    Uprev(1) = v1;
    Yprev(2:4) = Yprev(1:3);
    Yprev(1) = v;
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
        instantCoords(3);g],22*v*Tsampling)
    instantCoords(3) = twoRad(instantCoords(3));
    l2plot = l2plot + abs(22*v*Tsampling);
    x1 = [x1 instantCoords(1)];
    x2 = [x2 instantCoords(2)];
    x3 = [x3 instantCoords(3)];
    vp = [vp v];
    vp1 = [vp1 v1];
    gp = [gp g];
end
myCar(instantCoords(1),instantCoords(2),instantCoords(3),g);
axis equal; grid on; grid minor;