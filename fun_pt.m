function [f, c] = fun_pt(x, config, Vc, Rc)

    [tf, Yf] = simulate_trajectory(config, x);
    Rf = Yf(1:2);
    Vf = Yf(3:4);

    f = -norm(Vf);

    c1 = norm(Rf) - Rc;
    c2 = dot(Rf, Vf);  
    c = [c1; c2];
end
