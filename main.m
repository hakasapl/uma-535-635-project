% Main runner to determine offsets based on xcorr calculations. load_data.m
% must be run first.

clear;
load('temp.mat');

% Apply DC block on values (DC block is an external function that does a
% moving average)
out_values(:,1) = DCblock(out_values(:,1));
out_values(:,2) = DCblock(out_values(:,2));

total_data = size(out_timestamps,1);

start_time = datetime(2023, 3, 24, 0, 0, 0, 0);  % Adjust this based on data

fs = 20;
window_sec = 300;
window_overlap_sec = window_sec / 2;
window_samples = window_sec * fs;
window_overlap_samples = window_overlap_sec * fs;

offset_vec = [];

start_index = find(out_timestamps(:,1) == start_time);
end_index = start_index + window_samples;

while end_index < total_data
    xcorr_input = [];

    disp(start_index + "/" + total_data);
    if start_time ~= out_timestamps(start_index,1) || start_time ~= out_timestamps(start_index,2)
        % Break if start time doesn't match for some reason, this shouldn't
        % happen if the data is in-tact
        disp(out_timestamps(start_index,1))
        disp(start_time)
        break
    end

    for i = 1:2
        cur_values = out_values(start_index:end_index - 1,i);
        xcorr_input = [xcorr_input cur_values];
    end

    % Calculate XCorrelation
    cur_corr = xcorr(xcorr_input(:,1),xcorr_input(:,2));
    max_index = find(cur_corr==max(cur_corr));
    offset = (max_index - window_samples + 1) / 2 / fs;
    offset_vec = [offset_vec; offset];

    % Iterate
    start_index = start_index + window_overlap_samples;
    end_index = end_index + window_overlap_samples;

    start_time = start_time + seconds(window_overlap_sec);
end
