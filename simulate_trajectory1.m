function [tf, Yf, traj] = simulate_trajectory(config, thetas)

    mu  = ...;
    Rt  = ...;
    rho0 = ...; H = ...; cx = ...;

    t0 = 0;
    R0 = [Rt; 0];
    V0 = 100 * [cos(thetas(1)); sin(thetas(1))];
    M0 = config.M0;   
    Y0 = [R0; V0; M0];

    t = t0;  Y = Y0;
    traj.t = []; traj.Y = [];

    for j = 1:3
        Tj = config.T(j);      
        qj = config.q(j);     
        tj = config.tburn(j);  
        theta_j = thetas(j+1); 

        ode = @(t,Y) rhs_stage(t,Y,mu,Rt,H,rho0,cx,Tj,qj,theta_j);

        tspan = [t, t+tj];
        [tout,Yout] = ode45(ode, tspan, Y);

        traj.t = [traj.t; tout];
        traj.Y = [traj.Y; Yout];

        t = tout(end);
        Y = Yout(end,:)';

        Y(5) = Y(5) - config.ms(j);  % M -> M - ms_j
    end

    tf = t;  Yf = Y;
end
