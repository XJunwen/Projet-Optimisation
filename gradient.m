function [grad]=gradient(f,x, f_x, delta)
% f la fonction dont on calcule le gradient.
% x le point où l'on calcule le gradient (vecteur colonne).
% delta le pas pour l'approximation de type différences finis.
% f_x le vecteur (colonne) f(x).
% delta et f_x sont des arguments optionnels.
% grad la matrice des gradients (colonnes) au point x (soit donc la
% transposée de la jacobienne).
if nargin == 2
    f_x=f(x);
    delta=10^(-8); % Valeur par défaut pour le pas (choisie après tests, cf test_gradient.m).
end
if nargin == 3
    delta=10^(-8);
end
pas=zeros(length(x),1);
grad=zeros(length(x),length(f_x));
for i=1:length(x)
    pas(i)=delta;
    grad(i,:)=(f(x+pas)-f_x)./delta;
    pas(i,:)=0;
end
end