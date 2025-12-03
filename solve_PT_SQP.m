function [x_opt, info] = solve_PT_SQP(x0, params)


f  = @(x) PT_objective(x, params);
c  = @(x) PT_constraints(x, params);

tol = 1e-6;
max_iter = 50;

[x_opt, fval, info] = SQP(f, c, x0, tol, max_iter);

end
