clear
close all

methode="BFGS";

%%% Test 1 : fonctionnelle quadratique (1/2)<Qx,Qx> + <g,x> sous la 
%%% contrainte Ax-b=0. 

Q=eye(2,2);
g=[0;0];
A=[1,1];
b=1;
f1=@(x) 0.5*(Q*x).'*(Q*x) + g.'*x;
c1=@(x) A*x-b;
tol=10^(-4);
max_iter=100;
nfonc_max=250;
x=[5;4];
[sol1, f_sol1, c_sol1,iter1]=SQP(f1,c1,x,tol,max_iter,nfonc_max,methode);

% Avec SR1
% sol1=[0.5;0.5], f_sol1=0.25, c_sol1=5.4623e-14, iter1=1: on retrouve bien les
% valeurs théoriques avec les contraintes raisonnablement respectées et un
% nombre d'itération faible.

%%% Test 2 : MHW4D

f2=@(x) (x(1)-1)^2 + (x(1)-x(2))^2+(x(2)-x(3))^3 + (x(3)-x(4))^4 + (x(4)-x(5))^4;
c2=@(x) [ x(1)+x(2)^2+x(3)^2-3*sqrt(2)-2 ; x(2)-x(3)^2+x(4)-2*sqrt(2)+2 ; x(1)*x(5)-2 ];
tol=10^(-8);
max_iter=100;
nfonc_max=250;
x=[-1;2;1;-2;-2];
borne_inf=[-2;1;0;-3;-3];
borne_sup=[0;3;2;0;-1];
[sol2, f_sol2, c_sol2,iter2]=SQP(f2,c2,x,tol,max_iter,nfonc_max,methode,borne_inf,borne_sup);

% Avec SR1
% sol2=[-1.2369;2.4620;1.1908;-0.2157;-1.6169] : solution à
% 10^(-2) près
% f_sol2=28.5087 solution à 10^(0) près
% c_sol2=10^(-7)*[0.1202;-0.0992;-0.0013] : contraintes respectées à
% 10^(-7) près.
% iter2=17 : nombre raisonnable.

%%% Test 3 : Ariane1

mu=1700;
k=[0.1101; 0.1532; 0.2154];
v=[2647.2; 2922.4; 4344.3];
delta_requis=11527;
f3=@(x) masse_ariane1(x,k,mu);
c3=@(x) vitesse_ariane1(x,k,mu,v,delta_requis);
tol=10^(-4);
max_iter=200;
nfonc_max=250;
x_sol=[145349;31215; 7933];
x1=[200000;50000; 10000];
x2=[140000;30000; 7000];
borne_inf=[0;0;0];
borne_sup=[inf;inf;inf];
[sol3, f_sol3, c_sol3,iter3]=SQP(f3,c3,x1,tol,max_iter,nfonc_max,methode,borne_inf,borne_sup);

% Avec x_sol et SR1 : 
% sol3=[145371.859476;31240.411093;7960.731874]
% f_sol3=2.0878*10^5
% c_sol3=-0.000002
% iter5=5
% On reste bien autour du point de départ avec un précision raisonnable. 

% Avec x1 et SR1 : 
% sol3=10^5*[1.3073;0.5206;0.1006]
% f_sol3=2.1909*10^5
% c_sol3=1.3214*10^(-04)
% iter3=34
% Précision faible relativement aux valeurs de la slide. Problème dans 
% l'algorithme ou mauvais choix de pointe de départ ?

% Avec x2 et SR1 : 
% sol3=[142880.534452;33322.589894;8592.453744]
% f_sol3=2.0919*10^5
% c_sol3=-0.000726
% iter3=29
% C'est mieux que pour x1 : la sensibilité au point de départ semble assez
% forte. 

