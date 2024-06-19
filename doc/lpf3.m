function Y = lpf3(X, N, fc, q, g, fs)
    Y = zeros([1 N]);
    % Scale resonance to [1..10] based on q in [0..1]
    r = 1 + 9 * q;
    [Ai, Bi, K, alpha0] = oblpf_set_cutoff(fc, fs, r);
    Z1 = zeros([1 4]);
    for i = 1:N
        [Y(i), Z1] = oblpf_filter(X(i), Ai, Bi, Z1, K, g, alpha0);
    end
end

function [y, Z1i_out] = oblpf_filter(x, Ai, Bi, Z1i, K, g, alpha0)
    sigma = ...
        Bi(1) * Z1i(1) + Bi(2) * Z1i(2) + Bi(3) * Z1i(3) + Bi(4) * Z1i(4);
    input = x * (1.0 + K);
    u = (input - K * sigma) * alpha0;
    u = tanh(u * g);     % g used as saturation coefficient
    [s1, Z1i_out(1)] = one_pole_lpf(u, Z1i(1), Ai(1), 0);
    [s2, Z1i_out(2)] = one_pole_lpf(s1, Z1i(2), Ai(2), 0);
    [s3, Z1i_out(3)] = one_pole_lpf(s2, Z1i(3), Ai(3), 0);
    [s4, Z1i_out(4)] = one_pole_lpf(s3, Z1i(4), Ai(4), 0);

    y = s4;             % 4 pole filter
end

function [Ai, Bi, K, alpha0] = oblpf_set_cutoff(fc, fs, r)
    wd = 2 * pi * fc;
	T = 1 / fs;
    wa = (2 / T) * tan(wd * T / 2);
	g = wa * T / 2;
	% Feed-forward
    G = g / (1.0 + g);

    % One pole filters parameters:
    Ai = [G, G, G, G];
    beta1 = G*G*G / (g + 1);
    beta2 = G*G / (g + 1);
    beta3 = G / (g + 1);
    beta4 = 1 / (g + 1);
    Bi = [beta1, beta2, beta3, beta4];

    % Resonance: [1..10] => [0..4]
    K = 4 * (r - 1)/(10 - 1);

    gamma = G*G*G*G;
    alpha0 = 1 / (1 + K * gamma);
end

function [y , z1_out] = one_pole_lpf(x, z1, alpha, feedback)
    s = x + feedback;
    %feedback_output = beta * z1;
    vn = (s - z1) * alpha;
    y = vn + z1;
    z1_out = vn + y;
end
