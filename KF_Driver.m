function trace = KF_Driver(s, trace, w, dt, sigma_p)

state = trace(s, 1 : 3)';

state(1) = state(1);
state(2) = state(2);
state(3) = state(3) + w * dt + sqrt(sigma_p) * randn;

 trace(s + 1, 1 : 3) = state';