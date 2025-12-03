clear 
close all 

%%% Cas où la hessienne approchée est modifiée 

% Définitions des arguments

x_old=[1;2];
x=[3;4];
f=@(x) x(1)^2+x(2)^2-x(1);
c=@(x) [x(1)-x(2);x(1)-3*x(2)+x(1);-x(2)];
lambda=[1;2;3];
iter=1;

grad_f_old=gradient(f,x_old);
grad_c_old=gradient(c,x_old);
grad_f=gradient(f,x);
grad_c=gradient(c,x);
grad_l=lagrangien(grad_f,grad_c,lambda);
d=x-x_old;
H1=eye(length(x));
H2=[ 1 , 2 ; 1 , 2 ];

% Calcul de la nouvelle hessienne approchée 

new_H1=SR1(iter,grad_f_old,grad_c_old,H1,d,lambda,grad_l);
new_H2=SR1(iter,grad_f_old,grad_c_old,H2,d,lambda,grad_l);

% new_H1=[1.5,0.5;0.5,1.5] et new_H2=[0.5,1.5;0.5,1.5] : on retrouvre
% bien les valeurs théoriques. 

%%% Cas où la hessienne approchée n'est pas modifiée 

d2=[0;0]; % condition de calcul artificiellement mise à 0. 
new_H3=SR1(iter,grad_f_old,grad_c_old,H1,d2,lambda,grad_l);
erreur=norm(H1-new_H3);

% erreur=0 : la matrice new_H3 est bien égale à H1.

%%% Cas où la hessienne est réinitialisée

iter=length(d);
new_H4=SR1(iter,grad_f_old,grad_c_old,H2,d,lambda,grad_l);

% new_H4=[1,0;0,1] : H a bien été réinitialisée. 

%%%%%% Bilan : la fonction SR1 calcule bien la nouvelle itération 
%%%%%% de la hessienne approchée à partir de la précédente. 