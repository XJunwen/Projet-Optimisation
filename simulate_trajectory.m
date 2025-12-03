function [Rtf, Vtf, Mf, traj] = simulate_trajectory(x, params)
theta = x(1:3);
T     = x(4:6);
tburn = x(7:9);

R0 = params.R0;
V0 = params.V0;
M0 = params.M0;

state = [R0; V0; M0];  % [Rx; Ry; Vx; Vy; M]

traj = []; 

for j = 1:3
    theta_j = theta(j);

    ode = @(t, s) rocket_ode(t, s, T(j), theta_j, params);

    tspan = [0 tburn(j)];

    [~, sol] = ode45(ode, tspan, state);

    traj = [traj; sol];

    state = sol(end, :)';

    state(5) = state(5) - params.m_struct(j);
end

Rtf = state(1:2);
Vtf = state(3:4);
Mf  = state(5);

end
