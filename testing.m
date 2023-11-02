% This script will use ground-truth NTP data to compare the
% offset calculated using NTP to the one calculated by
% xcorrelation. Main.m must be run first

% Define range to check (the larger, the more accurate)
delta_sec = 3600 * 24 * 6;

% Define start/end time
start_time = datetime(2023, 3, 24, 0, 0, 0, 0);  % Adjust this based on data
end_time = start_time + seconds(delta_sec);

index_endtime = find(out_timestamps(:,1) == end_time);

indices_1 = find(out_systimes(:,1) >= start_time & out_systimes(:,1) < end_time);
indices_2 = find(out_systimes(:,2) >= start_time & out_systimes(:,2) < end_time);

% ntp_offset is the ground truth result
ntp_offset = (length(indices_2) - length(indices_1)) / fs;

cal_index = floor(index_endtime / window_overlap_samples);

% calculated_offset is the xcorr calculated result
calculated_offset = offset_vec(cal_index);
