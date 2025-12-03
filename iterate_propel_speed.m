function result = iterate_propel_speed(Vp_list, x0, params)

bestV = -inf;
bestX = [];
bestVp = [];

for Vp = Vp_list
    params.Vp = Vp;

    [x_opt, info] = solve_PT_SQP(x0, params);

    [~, Vtf] = simulate_trajectory(x_opt, params);
    V_final = norm(Vtf);

    fprintf("Vp = %.1f  => Final V = %.3f m/s\n", Vp, V_final);

    if V_final > bestV
        bestV = V_final;
        bestX = x_opt;
        bestVp = Vp;
    end
end

result.bestV  = bestV;
result.bestX  = bestX;
result.bestVp = bestVp;

end
