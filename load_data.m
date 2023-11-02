% Load data from the data folder
clear;

% Specify the folder where your CSV files are located
folder = 'data';

% List all CSV files in the folder that start with 'BAROLOG'
files = dir(fullfile(folder, 'BAROLOG*.txt'));

% Loop through each CSV file
timestamps = [];
sys_timestamps = [];
sensor_ids = [];
values = [];

out = table();
for i = 1:length(files)
    file_path = files(i).folder + "/" + files(i).name;
    cur_file_table = readtable(file_path);

    % Process NTP Time
    cur_times = datetime(cur_file_table{:, 3}, 'InputFormat', 'yyyy-MM-dd''T''HH:mm:ss.SSSSSS''Z');
    sys_timestamps = [sys_timestamps ; cur_times];

    % Process Sensor Time
    cur_times = datetime(cur_file_table{:, 4}, 'InputFormat', 'yyyy-MM-dd''T''HH:mm:ss.SSSSSS''Z');
    timestamps = [timestamps ; cur_times];

    % Process sensor id
    cur_sensorid = cur_file_table{:,2};
    sensor_ids = [ sensor_ids ; cur_sensorid ];

    % Process Values
    cur_values = cur_file_table{:,5};
    values = [values ; cur_values];
end

out_timestamps = [];
out_systimes = [];
out_values = [];

unique_ids = unique(sensor_ids);
for i = 1:length(unique_ids)
    cur_occur = find(sensor_ids==unique_ids(i));

    out_timestamps = [out_timestamps timestamps(cur_occur)];
    out_systimes = [out_systimes sys_timestamps(cur_occur)];
    out_values = [out_values values(cur_occur)];
end

save('temp.mat','out_timestamps','out_systimes','out_values');
clear;
