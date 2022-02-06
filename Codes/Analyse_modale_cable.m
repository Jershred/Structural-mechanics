clc
clear all
close all

%%% Analyse modale d'un câble fortement tendu %%%

% Donnés
rho=7770;
E=210e9;
sigma=1e8;
L=10;
r=5e-2; %rayon du cable
S=pi*r^2; %section du cable

% Discretisation
Ne=6; %nombre d'éléments
Nn=Ne+1; %nombre de noeuds
dx=L/Ne;

% Matrices élémentaires
Me=ones(2,2);
Me(1,1)=2;
Me(2,2)=2;
Me=rho*S*dx/6*Me;

Ke=ones(2,2);
Ke(1,2)=-1;
Ke(2,1)=-1;
Ke=sigma*S/dx*Ke;

% Assemblage
M=zeros(Nn,Nn);
K=zeros(Nn,Nn);

for i=1:Ne
  M(i:i+1,i:i+1)=M(i:i+1,i:i+1)+Me;
  K(i:i+1,i:i+1)=K(i:i+1,i:i+1)+Ke;
endfor

MK=M(2:Nn-1,2:Nn-1)+K(2:Nn-1,2:Nn-1);
[V,D] = eig(MK) %D la matrice diagonale valeurs propres de A
                %V la matrice dont les vecteurs colonnes sont les vecteurs propres correspondant
                
% Valeurs propres
v=zeros(Nn,Ne-1);
v(2:Nn-1,:)=V

% Graphe
x=[0:dx:L];
n=[0:L/(Ne-1):L];

figure('Name','Déplacement','Numbertitle','off')

for k=1:(Ne-1)
  j=2*k;
  subplot(Ne-1,2,j-1)
  plot(x,v(:,k));
  title(['Mode ',num2str(k)])
  xlabel('x(m)')
  ylabel('Déplacement(m)')
  set(gca,'FontSize',12)
endfor