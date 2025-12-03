function f = PT_objective(x, params)

[Rtf, Vtf, Mf] = simulate_trajectory(x, params);

V_final = norm(Vtf);

f = -V_final;

end
