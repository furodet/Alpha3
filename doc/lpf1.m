% LPF experiments: model 1
% Filters a vector X of N samples, using the specified:
%   - fc: cutoff frequency
%   - q: resonnance
%   - g: gain
%  Notice that the sampling frequency is set to 48KHz
function Y = lpf1(X, N, fc, q, g)
    Y = zeros([1 N]);
    [a0 , a1 , a2 , b1 , b2] = lpf1_compute_coefs(fc, q, g);
    z1 = 0;
    z2 = 0;
    for i = 1:N
        [Y(i), z1, z2] = lpf1_filter(X(i), a0 , a1 , a2 , b1 , b2, z1, z2);
    end
end

function [a0, a1, a2, b1, b2] = lpf1_compute_coefs(fc, q, g)
    sampling_freq = 48000;
    A = 1 + g;
    omega = 2 * pi * fc / single(sampling_freq);
    sn = sin(omega);
    cs = cos(omega);
    if q == 0
        alpha = single(1);
    else
        alpha = sn / (2 * q);
    end

    % Primary filter coefficients
    pb0 = (1 - cs) / 2;
    pb1 = 1 - cs;
    pb2 = (1 - cs) / 2;
    pa0 = 1 + alpha;
    pa1 = -2 * cs;
    pa2 = 1 - alpha;

    % Compensation of the gain loss
    a0 = single(pb0 / pa0 * A);
    a1 = single(pb1 / pa0 * A);
    a2 = single(pb2 / pa0 * A);
    b1 = single(pa1 / pa0);
    b2 = single(pa2 / pa0);
end

function [y, z1_out, z2_out] = lpf1_filter(x, a0, a1, a2, b1, b2, z1, z2)
    y = a0 * x + z1;
    z1_out = a1 * x + z2 - b1 * y;
    z2_out = a2 * x - b2 * y;
end
