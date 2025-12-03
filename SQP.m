function [sol,f_sol,c_sol,iter]=SQP(f,c,x,tol,max_iter,nfonc_max, methode,borne_inf,borne_sup)
% f la fonction à minimiser.
% c les contraintes d'égalité. 
% x le point de départ.
% tol la tolerance sur la norme du gradient du lagrengien. 
% max_iter le nombre maximal d'itération de SQP. 
% borne_inf les bornes inférieures sur la variable, borne_sup ses bornes
% supérieures. Les deux arguments sont optionnels si il n'y a pas 
% de borne sur la variable mais les deux doivent l'être sinon.
% sol un minimiseur à la tolérace tol près si l'itération maximale max_iter 
% n'est pas dépassée.
% f_sol et c_sol les quantités f(sol) et c(sol). 
% iter la dernière itération réalisée. 
iter=0; 
nfonc=0;
f_x=f(x);
nfonc=nfonc+1;
f_x_old=f_x+1+tol;
norm_grad_l=1+tol; % Initialisation artificielle pour pouvoir rentrer dans la boucle. 
d=1+min(x)*tol;
while norm_grad_l>tol && norm(d,1)>abs(min(x))*tol && abs(f_x-f_x_old)> tol && nfonc < nfonc_max && iter<max_iter

    iter=iter+1;
    if iter==1
        % Initialisation
        [c_x,grad_f,grad_c,norme_c,H,rho,nfonc]=SQP_initialisation(f,f_x,c,x,nfonc);
    else 
        % Approximation de la hessienne. 
        if methode=="SR1"
            H=SR1(iter,grad_f_old,grad_c_old,H,d,lambda,grad_l);
        elseif methode=="BFGS" 
            H=BFGS(iter,grad_f_old,grad_c_old,H,d,lambda,grad_l);
        end
        H=modif_defpos(H);
    end

    % Résolution du problème quadratique. 
    [new_d,lambda]=KKT_quad_lin(H,grad_f,grad_c.',-c_x);

    % d direction de descente de la fonction mérite
    check_descente=false;
    check_reset=false;
    while ~check_descente
        [dp_merite_x, new_d,lambda,H,rho,check_descente,check_reset]=is_descente(c_x, ...
            norme_c, grad_f,grad_c,new_d,lambda,H,rho,check_reset);
    end
    d=new_d;
    f_x_old=f_x;
    % Recherche linéaire
    merite_x=f_merite(rho,f_x,norme_c);
    if nargin == 7
        [d,x,f_x,c_x,norme_c,nfonc]=armijo(f,c,rho,d,x,merite_x,dp_merite_x,nfonc);
    else
        [d,x,f_x,c_x,norme_c,nfonc]=armijo(f,c,rho,d,x,merite_x,dp_merite_x,nfonc,borne_inf,borne_sup);
    end
    
    % Conservation des gradients dont on aura besoin à l'itération suivante.
    grad_f_old=grad_f;
    grad_c_old=grad_c;

    % Initialisation des données manquantes de l'itération suivante. 
    grad_f=gradient(f,x,f_x);
    nfonc=nfonc+length(x);
    grad_c=gradient(c,x,c_x);
    grad_l=lagrangien(grad_f,grad_c, lambda);
    norm_grad_l=norm(grad_l,1);

    % Affichage données
    affichage_donnee(iter,nfonc,x,f_x,c_x,lambda,norm_grad_l);
end
sol=x;
f_sol=f_x;
c_sol=c_x;
end