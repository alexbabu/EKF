function [mu_t, sigma_t] = KF_Predict(mu_tminus1, sigma_tminus1, u_t, z_t,...
    A_t, B_t, C_t, sigma_p, sigma_s)

R_t = sqrt(sigma_p) * eye(3,3);
Q_t = sqrt(sigma_s) * eye(3,3);

mu_bar_t = A_t * mu_tminus1 + B_t * u_t;

sigma_bar_t = A_t * sigma_tminus1 * A_t' + R_t;

K_t = sigma_bar_t * C_t' * (C_t * sigma_bar_t * C_t' + Q_t);

mu_t = mu_bar_t + K_t * (z_t - C_t * mu_bar_t);

sigma_t = (eye(3,3) - K_t * C_t) * sigma_bar_t;