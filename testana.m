
k  = [0.10; 0.15; 0.20];         
ve = [2600; 3000; 4400];        
Vp = 9000;    

x3_0    = 2.5;
tol     = 1e-12;
max_it  = 50;

[x_ana, info] = newton_PE_x3(k, ve, Vp, x3_0, tol, max_it);

fprintf('====== Résultat "analytique" (Newton sur x3) ======\n');
fprintf('x*  = [%.8f  %.8f  %.8f]\n', x_ana(1), x_ana(2), x_ana(3));
fprintf('psi(x3*) = %.3e\n', info.psi);
fprintf('V(x*)    = %.6f,   Vp = %.6f,  écart = %.3e\n', ...
        info.V_check, Vp, info.c);
fprintf('Nb itérations Newton : %d\n', info.iter);
%====== Résultat "analytique" (Newton sur x3) ======
%x*  = [1.92871430  2.18724359  3.07619717]
%psi(x3*) = -1.164e-04
%V(x*)    = 9000.000000,   Vp = 9000.000000,  écart = 0.000e+00
%Nb itérations Newton : 6