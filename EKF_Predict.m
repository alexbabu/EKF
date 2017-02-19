function [mu_t, sigma_t] = EKF_Predict(mu_bar_t, sigma_tminus1, G_t, ...
    sigma_p, H_t, sigma_s, z_t)

R_t = sqrt(sigma_p) * eye(3,3);
Q_t = sqrt(sigma_s) * eye(3,3);

sigma_bar_t = G_t * sigma_tminus1 * G_t' + R_t;

K_t = sigma_bar_t * H_t' *((H_t * sigma_bar_t * H_t' + Q_t) ^ -1);

mu_t = mu_bar_t + K_t *(z_t - H_t * mu_bar_t);

sigma_t = (eye(3,3) - K_t * H_t) * sigma_bar_t;