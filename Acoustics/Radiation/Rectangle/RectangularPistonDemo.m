clear all; close all; clc;

% Rectangle size
a = 1;
b = 3;

% Incomming wave angle
theta = 0;
phi = 0; 

% Wave number
k = linspace(0,10,50);

% Degree to radianer
DegToRad = pi/180;

f = RectangularFieldExcitedPiston(k, theta, phi, a, b,1);

theta = 45;
phi = 45;

f1 = RectangularFieldExcitedPiston(k, theta*DegToRad, phi*DegToRad, a, b,1);
figure

subplot(2,1,1)
hold on;
plot(k,f)
plot(k,imag(f))
title('Normalized radiation impedance of rectangle')

subplot(2,1,2)
hold on;
plot(k,f1)
plot(k,imag(f1))
title(strjoin(['Field excited with Theta = ', string(t), ' and Phi = ' , string(p), ' degrees']))
