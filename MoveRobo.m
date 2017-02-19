function trace = MoveRobo(intial_state, u, dt, t)

v = u(1);
w = u(2);

% intial_state = [0; 0 ; 0];
% nMenu = 1;

nSteps = t / dt;

if(v)
    trace = EKF_Robot(intial_state, v, dt, nSteps);
else
    trace = KF_Robot(intial_state, w, dt, nSteps);
end

plot(trace(:, 1), trace(:, 2), 'r.'); hold all;
plot(trace(:, 4), trace(:, 5), 'g.'); hold all;
plot(trace(:, 7), trace(:, 8), 'b.'); hold all;

% while(nMenu)
%     nMenu = input('For ending motion press 0 and for continuing press 1');
% 
%     if(nMenu)
%         [nRows, nCols] = size(trace);
% 
%         iniital_state = trace(nRows - 1, 7 : 9);
% 
%         trace = MoveRobo(intial_state, u, dt, t);
%         
%         plot(trace(:, 1), trace(:, 2), 'r.'); hold all;
%         plot(trace(:, 4), trace(:, 5), 'g.'); hold all;
%         plot(trace(:, 7), trace(:, 8), 'b.'); hold all;
%     end
% end