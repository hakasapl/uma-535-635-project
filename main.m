% Main runner to determine offsets based on xcorr calculations. load_data.m
% must be run first.

clear;
load('data.mat');

fs = 20;

% Apply DC block on values (DC block is an external function that does a
% moving average)
out_0_values(:,1) = DCblock(out_values(:,1));
out_0_values(:,2) = DCblock(out_values(:,2));
%out_0_values(:,1) = bandpass(out_values(:,1),[2 4],fs);
%out_0_values(:,2) = bandpass(out_values(:,2),[2 4],fs);

total_data = size(out_timestamps,1);

window_sec = 300;
window_samples = window_sec * fs;

offset_vec = [];

start_index = window_samples;
end_index = start_index + window_samples;

last_xcorr = -0.45;

while end_index < total_data - window_samples
    disp(start_index + "/" + total_data);

    xcorr_input_1 = out_0_values(start_index:end_index - 1, 1);
    xcorr_input_2 = out_0_values(start_index:end_index - 1, 2);

    % Calculate XCorrelation
    cur_corr = xcorr(xcorr_input_1, xcorr_input_2);
    max_index = find(cur_corr==max(cur_corr));
    offset = (max_index - window_samples) / fs;

    if offset + (1/fs) >= last_xcorr && offset - (1/fs) <= last_xcorr
       offset_vec = [offset_vec; offset];
       last_xcorr = offset;
    else
       offset_vec = [offset_vec; last_xcorr];
    end

    % Iterate
    start_index = start_index + window_samples;
    end_index = end_index + window_samples;
end

offset_vec_size = size(offset_vec, 1);

% Calculate Final Drift using LinReg
drift_coeff = polyfit(1:offset_vec_size, offset_vec, 1);
drift_xFit = 1:offset_vec_size;
drift_yFit = polyval(drift_coeff, drift_xFit);

% Print final average drift value
drift_calc = drift_coeff(1) / window_samples * fs * 3600;
disp(drift_calc)