function [next_index, sample_id] = basic_lerp(current_index, frequency, pshft, osc_sampling_freq, wave_len)
increment = frequency * wave_len / double(osc_sampling_freq);
next = current_index + increment;
next_index = double(mod(next, wave_len));
sample = current_index + pshft;
sample_id = double(floor(mod(sample, wave_len)));
