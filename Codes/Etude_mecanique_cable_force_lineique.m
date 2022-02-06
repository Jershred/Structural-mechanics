clc
clear all
close all

%%% Etude mécanique d'un cable fortement tendu %%%

% Donnés
rho=7770;
E=210e9;
sigma=1e8;
L=10;
r=5e-2; %rayon du cable
S=pi*r^2; %section du cable

f=-rho*L*S*9.81; %force équivalente au poids du câble

% Discretisation
Ne=6; %nombre d'éléments
Nn=Ne+1; %nombre de noeuds
dx=L/Nn;

% Matrices élémentaires
Ke=ones(2,2);
Ke(1,2)=-1;
Ke(2,1)=-1;
Ke=sigma*S/dx*Ke;

F=f/dx*ones(5,1);

% Assemblage
K=zeros(Nn,Nn);

for i=1:Ne
  K(i:i+1,i:i+1)=K(i:i+1,i:i+1)+Ke;
endfor

Kinf=zeros(Nn-2,Nn-2);
for i=1:Nn-2
  for j=1:Nn-2
    Kinf(i,j)=K(i+1,j+1);
  endfor
endfor

% Résolution
u=Kinf\F;
U=[0;u;0];

F1=-E*S/L*U(2)+f/Nn
Fn=-E*S/L*U(Ne)+f/Nn

Sigma1=E/L*[-1 1]*[U(1);U(2)];
Sigma2=E/L*[-1 1]*[U(2);U(3)];
Sigma3=E/L*[-1 1]*[U(3);U(4)];
Sigma4=E/L*[-1 1]*[U(4);U(5)];
Sigma5=E/L*[-1 1]*[U(5);U(6)];
Sigma6=E/L*[-1 1]*[U(6);U(7)];

SIGMA=[ones(1,100)*Sigma1,ones(1,100)*Sigma2,ones(1,100)*Sigma3,ones(1,100)*Sigma4,ones(1,100)*Sigma5,ones(1,100)*Sigma6];

%Graphe
x=linspace(0,L,Nn);
x2=linspace(0,L,100*Ne);

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