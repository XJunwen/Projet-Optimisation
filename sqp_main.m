function H = bfgs_update(H, s, y)
sy = s'*y;
if sy <= 1e-12, return; end
Hs = H*s;
sts = s'*Hs;
H = H + (y*y.')/sy - (Hs*Hs.')/sts;
end

function  H = hessianl(f, C, xk, lambda, h)

x = xk(:);
c0 = C(x);        m = numel(c0);
n=numel(xk);
H = eye(n);                
[g,J] = grad(f, xk, h,C);      
gL = g + J.'*lambda;                 
c = C(x);
A   = J;     
rhs = [-gL; -c];
KKT = [H   A.'; 
       A zeros(m,m)];
sol = KKT \ rhs;
d   = sol(1:n);
lam_qp = sol(n+1:end);               
x_new = x + d;
lambda_new = lam_qp;                  
[g2, J2] = grad(f, x_new, h,C);
 gL_new = g2 + J2.'*lambda_new;
 s = d;
 y = gL_new -  g - J.'*lambda_new;
 H = bfgs_update(H, s, y);
 x = x_new; lambda = lambda_new;
end


function [x, lambda] = sqp_main(f, C, x0, lambda0, params)
x       = x0(:);
lambda  = lambda0(:);
H       = eye(numel(x));      

for k = 1:maxit
    % Étape 2 : Gradient et Jacobien (Différences finies)
    [g,J] = grad(f, x, h,C)
    % Étape 3 : Hessien du lagrangien (Quasi-Newton)
    % Étape 4 : Modification du Hessien (définie positive
    % Étape 5 : Résolution du problème quadratique
    %  résoudre le système KKT pour obtenir (d, mu)
    %  d : direction de déplacement, mu : multiplicateurs du QP
    % Étape 6 : Globalisation (fonction mérite
    % Étape 7 : Recherche linéaire (condition d'Armijo)
    % -> si pas acceptable, réduire s (s = s/2)
     % Étape 8 : Mise à jour des variables
    % x_{k+1} = x_k + s*d
    % lambda_{k+1} = mu
    % H_{k+1} = bfgs_update(H, s*d, y)
    % Étape 9 : Tests d'arrêt
end
end
