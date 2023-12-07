% Load data from the data folder
clear;

% Specify the folder where your CSV files are located
folder = 'data';

% List all CSV files in the folder that start with 'BAROLOG'
files = dir(fullfile(folder, 'BAROLOG*.txt'));

num_days_data = 30;  % for preallocation
num_samples = (num_days_data * 2 + 1) * 24 * 3600 * 20;

% Loop through each CSV file
timestamps = NaT(num_samples, 1);
sys_timestamps = NaT(num_samples, 1);
sensor_ids = zeros(num_samples, 1);
values = zeros(num_samples, 1);

cur_index = 1;

out = table();
for i = 1:length(files)
    file_path = files(i).folder + "/" + files(i).name;
    disp(file_path)
    cur_file_table = readtable(file_path);

    lengths = zeros(1,4);

    % Process NTP Time
    cur_systimes = datetime(cur_file_table{:, 3}, 'InputFormat', 'yyyy-MM-dd''T''HH:mm:ss.SSSSSS''Z');
    lengths(1) = length(cur_systimes);
    sys_timestamps(cur_index:cur_index + lengths(1) - 1) = cur_systimes;

    % Process Sensor Time
    cur_times = datetime(cur_file_table{:, 4}, 'InputFormat', 'yyyy-MM-dd''T''HH:mm:ss.SSSSSS''Z');
    lengths(2) = length(cur_times);
    timestamps(cur_index:cur_index + lengths(2) - 1) = cur_times;

    % Process sensor id
    cur_sensorid = cur_file_table{:,2};
    lengths(3) = length(cur_sensorid);
    sensor_ids(cur_index:cur_index + lengths(3) - 1) = cur_sensorid;

    % Process Values
    cur_values = cur_file_table{:,5};
    lengths(4) = length(cur_values);
    values(cur_index:cur_index + lengths(4) - 1) = cur_values;

    if length(unique(lengths)) > 1
        error("Mismatching sizes!")
    end

    cur_index = cur_index + length(cur_values);
end

% Trim
lastValidIndex = find(values ~= 0, 1, 'last');

trimmed_sys_timestamps = sys_timestamps(1:lastValidIndex);
trimmed_timestamps = timestamps(1:lastValidIndex);
trimmed_sensor_ids = sensor_ids(1:lastValidIndex);
trimmed_values = values(1:lastValidIndex);

out_timestamps = [];
out_systimes = [];
out_values = [];

unique_ids = unique(trimmed_sensor_ids);
for i = 1:length(unique_ids)
    cur_occur = find(sensor_ids==unique_ids(i));

    out_timestamps = [out_timestamps trimmed_timestamps(cur_occur)];
    out_systimes = [out_systimes trimmed_sys_timestamps(cur_occur)];
    out_values = [out_values trimmed_values(cur_occur)];
end

save('data.mat','out_timestamps','out_systimes','out_values');
