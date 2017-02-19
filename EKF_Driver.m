function trace = EKF_Driver(s, trace, v, dt, sigma_p)

state = trace(s, 1 : 3)';

state(1) = state(1) + v * sin(state(3)) * dt + sqrt(sigma_p) * randn;
state(2) = state(2) + v * cos(state(3)) * dt + sqrt(sigma_p) * randn;
state(3) = state(3) + sqrt(sigma_p) * randn;

 trace(s + 1, 1 : 3) = state';