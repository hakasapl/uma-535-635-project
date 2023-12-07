file = 'newdata.csv';
output_file = 'data.mat';

% Import csv file
cur_file_table = readtable(file);

% Process sensor id
sensorids = cur_file_table{:,5};

% Process System Time
systimes = cur_file_table{:,6} / 1e9;

% Process Sensor Time
times = cur_file_table{:,7} / 1e9;

% Process Values
values = cur_file_table{:,8};

num_samples = length(values) / 2;
out_timestamps = zeros(num_samples, 2);
out_systimes = zeros(num_samples, 2);
out_values = zeros(num_samples, 2);

% Split lists
unique_ids = unique(sensorids);
for i = 1:length(unique_ids)
    cur_occur = find(sensorids==unique_ids(i));

    out_timestamps(:,i) = times(cur_occur);
    out_systimes(:,i) = systimes(cur_occur);
    out_values(:,i) = values(cur_occur);
end

save(output_file,'out_timestamps','out_systimes','out_values');
