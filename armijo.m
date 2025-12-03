function [new_d,x_pas,f_pas,c_pas, norme_pas,nfonc]=armijo(f,c,rho,d,x,merite_x,dp_merite_x,nfonc,borne_inf,borne_sup)
% f la fonction à minimiser.
% c les contraintes d'égalités.
% rho le paramètre de pénalisation.
% d une direction de descent au point x. 
% merite_x la fonction mérite calculée au point x.
% dp_merite_x la dérivée partielle de la fonction mérite selon d au point
% x. 
% x_pas le prochain point atteint avec en ajoutant pas.
%  f_pas et c_pas les valeurs de f et c en x_pas.
% norme_pas la norme 1 de c(x_pas). 
% borne_inf les bornes inférieures sur la variable, borne_sup ses bornes
% supérieures. Les deux arguments sont optionnels si il n'y a pas 
% de borne sur la variable mais les deux doivent l'être sinon.
pas=1;
coef=0.1;
x_pas=x+pas*d;
f_pas=f(x_pas);
nfonc=nfonc+1;
c_pas=c(x_pas);
norme_pas=norm(c_pas,1);
merite_pas=f_merite(rho,f_pas,norme_pas); 
while merite_pas > merite_x+coef*pas*dp_merite_x
    pas=pas/2;
    x_pas=x+pas*d;
    f_pas=f(x_pas);
    nfonc=nfonc+1;
    c_pas=c(x_pas);
    norme_pas=norm(c_pas,1);
    merite_pas=f_merite(rho,f_pas,norme_pas);
end
if nargin > 8
    for i=1:length(x_pas)
        x_pas(i)=max(x_pas(i),borne_inf(i));
        x_pas(i)=min(x_pas(i),borne_sup(i));
    end
    f_pas=f(x_pas);
    nfonc=nfonc+1;
    c_pas=c(x_pas);
    norme_pas=norm(c_pas,1);
end
new_d=x_pas-x;
end