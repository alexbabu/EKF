function trace = EKF_Robot(initial_state, v, dt, max_steps)

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
    trace = EKF_Driver(s, trace, v, dt, sigma_p);

    trace = EKF_Measurement(s, trace, sigma_s);
    
    mu_bar_t = trace(s,1:3)';
    
    G_t = [1 0 -v * sin(mu_bar_t(3) * dt);
            0 1 v * cos(mu_bar_t(3) * dt);
            0 0 1];
    H_t = eye(3, 3);
    z_t = trace(s, 4 :6)';
    
    [mu_t, Sigma_t] = EKF_Predict(mu_bar_t, Sigma_t_minus_1, G_t, ...
    sigma_p, H_t, sigma_s, z_t);

    Sigma_t_minus_1 = Sigma_t;
    trace(s,7:9) = mu_t';
end
