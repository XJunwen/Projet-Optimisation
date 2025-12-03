function [f_merite_x]=f_merite(rho,f_x,norme_c)
% rho le paramètre de pénalisation.
% f_x la quantité f(x) et norme_c la norme 1 de c(x) où f est la fonction à 
% minimiser et c les contraintes d'égalités. 
% f_merite_x l'image de x par la fonction mérite.
f_merite_x=f_x+rho*norme_c;
end