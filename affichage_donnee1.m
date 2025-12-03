function affichage_donnee(iter,nfonc,x,f_x,c_x,lambda,norm_grad_l) 
% iter l'itération réalisée
% nfonc le nombre d'appel depuis le début de la fonction f ç la fin de
% iter.
% x le point obtenue à la fin de iter.
% f_x et c_x les quantités f(x) et c(x).
% lambda les multiplicateurs de Lagrange. 
% norm_grad_l la norme 1 du gradient du lagrengien en (x,lambda). 
x_str="(";
lambda_str="(";
c_str="(";
n=length(x);
m=length(lambda);
for i=1:n
    if n==1
        x_str=sprintf("%f",x);
    else
        if i<n
            x_str=strcat(x_str,sprintf("%f;",x(i)));
        else
            x_str=strcat(x_str,sprintf("%f)",x(i)));
        end
    end
end
for i=1:m
    if m==1
       lambda_str=sprintf("%f",lambda);
       c_str=sprintf("%f",c_x);
    else
        if i<m
            lambda_str=strcat(lambda_str,sprintf("%f;",lambda(i)));
            c_str=strcat(c_str,sprintf("%f;",c_x(i)));
        else
            lambda_str=strcat(lambda_str,sprintf("%f)",lambda(i)));
            c_str=strcat(c_str,sprintf("%f)",c_x(i)));
        end
    end
end
tableau=table(iter,nfonc,x_str,f_x,c_str,lambda_str,norm_grad_l, ...
    'VariableNames', ["Itération", "Nombre d'appels de f", ...
    "Point x obtenu", "f(x)","c(x)","Multiplicateurs", ...
    "Norme du gradient en (x,lambda)"]);
display(tableau);

end