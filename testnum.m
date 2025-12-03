k  = [0.10, 0.15, 0.20];        
ve = [2600, 3000, 4400];      

Vp = 9000 ;  
f = @(x) - ((1 + k(1))/x(1) - k(1)) ...
         * ((1 + k(2))/x(2) - k(2)) ...
         * ((1 + k(3))/x(3) - k(3));
c = @(x) ve(1)*log(x(1)) + ve(2)*log(x(2)) + ve(3)*log(x(3)) - Vp;
x0 = [2;2;3];
tol       = 1e-12;
max_iter  = 100;
nfonc_max = 1000;
methode   = 'SR1';        

borne_inf = [1.01; 1.01; 1.01];
borne_sup = [100;   100;   100];
[sol, f_sol, c_sol, iter] = SQP( ...
    f, c, x0, tol, max_iter, nfonc_max, methode, borne_inf, borne_sup);

fprintf('\n=== Résultat SQP pour le problème PE ===\n');
fprintf('x* = [%.8f  %.8f  %.8f]\n', sol(1), sol(2), sol(3));
fprintf('c(x*) = %.3e \n', c_sol);
fprintf('f(x*) = %.8e\n', f_sol);
J_num = -f_sol;   
fprintf('J_num = m_u/M0 = %.8e\n', J_num);
fprintf('Nombre d''itérations SQP : %d\n\n', iter);
Omega = k ./ (1 + k);   % 1x3
cte1 = ve(1) * (1 - Omega(1) * sol(1));
cte2 = ve(2) * (1 - Omega(2) * sol(2));
cte3 = ve(3) * (1 - Omega(3) * sol(3));
fprintf('KKT cte  %.6f  %.6f  %.6f\n', cte1, cte2, cte3);
%=== Résultat SQP pour le problème PE ===
%x* = [2.05836030  2.07406624  3.06938631]
%c(x*) = -1.700e-05 
%f(x*) = -3.35517529e-02
%J_num = m_u/M0 = 3.35517529e-02
%Nombre d'itérations SQP : 61

%KKT cte  2113.478475  2188.408862  2149.116703