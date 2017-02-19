function trace = EKF_Measurement(s, trace, sigma_s)

state = trace(s, 1 : 3)';

trace(s, 4 : 6) = state' + mvnrnd(zeros(1,3),sigma_s*eye(3,3));