clear
close all 

%%% Lambda fonctions
 
%  Fonctions uselles 

carre = @(x) x.^2;
rcarre = @(x) sqrt(x);
cube = @(x) x.^3;
cos = @(x) cos(x);
sin = @(x) sin(x);
tan = @(x) tan(x);
exp = @(x) exp(x);
log = @(x) log(x);

% Dérivée des fonctions usuelles 

dcarre = @(x) 2*x;
drcarre = @(x) 1./(2.*sqrt(x));
dcube = @(x) 3*x.^2;
dcos = @(x) -sin(x);
dsin = @(x) cos(x);
dtan = @(x) 1+tan(x).^2;
dexp = @(x) exp(x);
dlog = @(x) 1./x;

%%%  Test du gradient 1D pour différentes valeurs de pas et différentes
%%%  valeurs de x. 

X=linspace(-25,25,100);
for k=1:length(X)

    % Calculs
    
    x=X(k);
    delta=logspace(-15,-1,100);
    erreur=zeros(8,length(delta)); 
    % Une ligne de erreur représente l'erreur sur le gradient en fonction 
    % des différentes valeurs de pas pour une fonction usuelle donnée.
    delta_optimal=zeros(8,length(X));
    % Détermine le delta tel que l'erreur soit minimale pour une fonction
    % usuelle (ligne) et une valeur de x données (colonne).
    for i=1:length(delta)
        f_x=carre(x);
        erreur(1,i)=abs( dcarre(x)-gradient(carre, x, f_x, delta(i)) );
        f_x=rcarre(x);
        erreur(2,i)=abs( drcarre(x)-gradient(rcarre, x, f_x, delta(i)) );
        f_x=cube(x);
        erreur(3,i)=abs( dcube(x)-gradient(cube, x, f_x, delta(i)) );
        f_x=cos(x);
        erreur(4,i)=abs( dcos(x)-gradient(cos, x, f_x, delta(i)) );
        f_x=sin(x);
        erreur(5,i)=abs( dsin(x)-gradient(sin, x, f_x, delta(i)) );
        f_x=tan(x);
        erreur(6,i)=abs( dtan(x)-gradient(tan, x, f_x, delta(i)) );
        f_x=exp(x);
        erreur(7,i)=abs( dexp(x)-gradient(exp, x, f_x, delta(i)) );
        f_x=log(x);
        erreur(8,i)=abs( dlog(x)-gradient(log, x, f_x, delta(i)) );
    end
    for i=1:8
        [~,min_index]=min(erreur(i,:));
        delta_optimal(i,k)=delta(min_index);
    end
    
    % Affichage graphique des résultats
    
    hold on
    set(gcf, 'visible', 'off')
    for i=1:8
        loglog(delta, erreur(i,:));
    end
    xlabel("Delta")
    ylabel(sprintf("Erreur approximation gradient pour x=%f",x));
    legend("carré", "racine carrée", "cube", "cos", "sin", "tan", "exp", "log")
    set(gca, 'XScale', 'log', 'YScale', 'log');
    grid on
    saveas(gcf, ...
        sprintf("Graphiques tests gradient/Erreur approximation gradient pour x=%f.png",x))
    hold off
    clf 

end % Fin boucle sur k.

% Le gradient semble bien converger correctement d'après les figures pour
% un pas petit comme attendu théoriquement (attention aux erreurs
% d'arrondis si il est trop petit cependant).

% Détermination du delta minimisant l'erreur moyen avec les tests précédents :

moy_delta_optimal=sum(delta_optimal,"all")/(8*length(X));
% Valeur de l'ordre de 10^(-9) : on fait ce choix pour une valeur par
% défaut de delta. 


%%% Test du gradient en plusieurs dimensions pour une fonction à valeurs 
%%% réelles.

x=[4;5];
test_f_1=@(x) x(1)*x(2);
test_grad_1=gradient(test_f_1,x);

% test_grad_1=[5;4] : on retrouve les valeurs théoriques. 

x=[3;5;1;-2];
test_f_2=@(x) exp(x(1))-x(1)^2/x(2)+x(4);
test_grad_2=gradient(test_f_2,x);

% test_grad_2=[18.8855;0.3600;0;1.0000] : on retrouve les valeurs
% théoriques.

%%% Test du gradient en plusieurs dimensions pour une fonction à valeurs 
%%% vectorielles.

x=[2;3;1];
test_f_3=@(x) [ x(1)*x(2)^2 ; 3*x(3) + 5*x(1) ];
test_grad_3=gradient(test_f_3,x);

% test_grad_3=[9,5 ; 12,0 ; 0,3] : on retrouve les valeurs théoriques.

%%%%%% Bilan : la fonction gradient fonctionne correctement en dimension 1.
%%%%%% Les trois tests sont également concluants en dimension supérieure. On
%%%%%% peut conclure que la fonction fait bien ce qui est attendu d'elle. De
%%%%%% plus, les tests ont permis d'identifier un ordre de grandeur du delta
%%%%%% à choisir par défaut pour la méthode des différences finis
%%%%%% afin d'augmenter la probabilité de minimiser l'erreur d'approximation
%%%%%% sur les dérivées dans le cas des fonctions usuelles. 

