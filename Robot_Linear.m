function trace = PR_EKF_1DOF(l, v, dt, max_steps)

% Process variance
sigma_p = 0.0000001;

% Sensor variance
sigma_s = 0.001;

% Initial State
state = [l,0,0]';

% correction, Look later
Sigma_t_minus_1 = zeros(3,3);

trace = zeros(max_steps+1,9);

% recording inital state and measurement
trace(1,1:3) = state';
trace(1,4:6) = state' + mvnrnd(zeros(1,3),sigma_s*eye(3,3));

for s = 1 : max_steps
%     updating the states
    trace = Kalman_Driver(s, trace, l, w, dt, sigma_p);

    trace = Kalman_Measurement(s, trace, sigma_s);
    
    [trace, Sigma_t_minus_1] = Kalman_Predict(s, trace, l, w, dt, Sigma_t_minus_1, ...
        sigma_p, sigma_s);
end

%     state(1) = state(1) - l*sin(state(3))*w*dt + sqrt(sigma_p)*randn;
%     state(2) = state(2) + l*cos(state(3))*w*dt + sqrt(sigma_p)*randn;
%     state(3) = state(3) + w*dt + sqrt(sigma_p)*randn;

%     trace(s+1,1:3) = state';
%     trace(s+1,4:6) = state' + mvnrnd(zeros(1,3),sigma_s*eye(3,3));