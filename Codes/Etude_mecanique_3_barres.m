clc
clear all
close all

%%% Etude mécanique d'un système 3 barres %%%

% Donnés
E1=E3=2.1e11;
L1=1;
L3=0.5;
S1=1e-4;
S3=2e-5;
E2=7e10;
L2=0.25;
S2=5e-4;
f=100;
Ne=3;

% Matrices
K=[E1*S1/L1+E2*S2/L2 -E2*S2/L2;-E2*S2/L2 E2*S2/L2+E3*S3/L3];
F=[f;0];

% Résolution
u=K\F;
U=[0;u;0];

F1=-E1*S1/L1*U(2)
F4=-E3*S3/L3*U(3)

Sigma1=E1/L1*[-1 1]*[U(1);U(2)];
Sigma2=E2/L2*[-1 1]*[U(2);U(3)];
Sigma3=E3/L3*[-1 1]*[U(3);U(4)];

SIGMA=[ones(1,100)*Sigma1,ones(1,100)*Sigma2,ones(1,100)*Sigma3]

%Graphe
x=[0;L1;L1+L2;L1+L2+L3];
x2=linspace(0,L1+L2+L3,100*Ne)

figure(1)

plot(x,U);
xlabel('x(m)')
ylabel('Déplacement(m)')
set(gca,'FontSize',34)

figure(2)

plot(x2,SIGMA);
xlabel('x(m)')
ylabel('Contraite(m)')
set(gca,'FontSize',34)