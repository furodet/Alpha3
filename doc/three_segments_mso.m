function sample = three_segments_mso(id, p_pw, p_slope, wave_len)
    pw_percent = p_pw / 127;
    slope_percent = p_slope / 127;
    [xl, xh, slope] = compute_three_segment_mso_params(pw_percent, slope_percent, wave_len, -1, 1);
    sample = ramp(id, xl, xh, slope, -1, 1);
end

function sample = ramp(id, xl, xh, slope, min, max)
    if id < xl
        sample = single(min);
    elseif id >= xh
        sample = single(max);
    else
        sample = single(min + (id - xl) * slope);
    end
end
function [xl, xh, slope] = compute_three_segment_mso_params(pw_percent, slope_percent, wave_len, min, max)
    % Segment 3 is the portion of the signal where amplitude is at maximum.
    % Its length is between half of the wave length (pw_percent = 0)
    % to 0 (pw_percent = 1)
    % The corresponding start point is at wave_len minus the segment3
    % length
    segment3_len = (1 - pw_percent) * (wave_len / 2);
    xh = single(wave_len - segment3_len);
    % Segment 1 is the portion of the signal where amplitude is at minimum.
    % Its length is defined by slope_percent as an amount of the size of
    % the signal once segment 3 is removed from the wave_length, in other
    % words xl. xh is exactly at the end of this segment.
    % Assume that when the slope is null, the length of segment 2 is null.
    segment1_len = (1 - slope_percent) * xh;
    xl = single(segment1_len);
    % Segment 2 represents the linear growth of the amplitude and is
    % between xl and xh.
    amplitude = max - min;
    delta = xh - xl;
    if delta == 0
        slope = 0;
    else
        slope = single(amplitude / delta);
    end
end
