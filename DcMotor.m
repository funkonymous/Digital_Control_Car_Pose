clc;clear all;close all force;
%hold on;
grid on; grid minor;
num = 0.5;
den = [0.025 0.3 0.5];
motor_tf = tf(num,den);
%step(motor_tf);
Ts = 0.0001; 
motord = c2d(motor_tf,Ts,'zoh');
s = tf('s');
Kp = 300; Ki = 400; Kd = 20;
pid = Kp + Ki/s + Kd*s; 
pidd = c2d(pid,Ts,'tustin');
closedloop = feedback(pidd*motord,1);
hold on; grid on; grid minor;
%rlocus(motord)
step(closedloop); 
step(motord);
grid on; grid minor;
