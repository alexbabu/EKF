function trace = KF_Robot(initial_state, w, dt, max_steps)

% Process variance
sigma_p = 0.001;

% Sensor variance
sigma_s = 0.001;

% Initial State
state = initial_state;

% correction, Look later
Sigma_t_minus_1 = zeros(3,3);

trace = zeros(max_steps+1,9);

% recording inital state and measurement
trace(1,1:3) = state';
trace(1,4:6) = state' + mvnrnd(zeros(1,3),sigma_s*eye(3,3));

for s = 1 : max_steps
%     updating the states
    trace = KF_Driver(s, trace, w, dt, sigma_p);

    trace = KF_Measurement(s, trace, sigma_s);
    
    mu_tminus1 = trace(s,1:3)';
    u_t = [0; w];
    z_t = trace(s,4:6)';
    A_t = eye(3,3);
    B_t = zeros(3,2);
    B_t(3,2) = dt;
    C_t = A_t;
    
    [mu_t, Sigma_t] = KF_Predict(mu_tminus1, Sigma_t_minus_1, u_t, z_t,...
    A_t, B_t, C_t, sigma_p, sigma_s);

    Sigma_t_minus_1 = Sigma_t;
    trace(s,7:9) = mu_t';
end