function [grad_l, l_x]=lagrangien(grad_f,grad_c, lambda, f_x,c_x)
% grad_f et grad_c les gradients de f et c au point x. 
%lambda le vecteur (colonne) des multiplicateurs de Lagrange. 
% l_x la valeur du lagrangien en (x,lambda).
% grad_l le gradient partiel selon x du lagrangien en (x,lambda).
% f_x le réel f(x) pour la fonction f à minimiser.
% c_x le vecteur c(x) de la contrainte d'égalité.
% f_x et c_x sont optionnels si on ne veut calculer que grad_l.
grad_l=grad_f+grad_c*lambda;
if nargout==2 && nargin==5
    l_x=f_x+lambda.'*c_x;
end
end