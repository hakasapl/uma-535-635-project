% Calculate drift

diff_timestamps_1 = out_timestamps(:,1) - out_systimes(:,1);
diff_timestamps_2 = out_timestamps(:,2) - out_systimes(:,2);

len_time = length(diff_timestamps_1);
drift_x = 1:len_time;

drift_coeff_1 = polyfit(drift_x, diff_timestamps_1, 1);
drift_coeff_2 = polyfit(drift_x, diff_timestamps_2, 1);
drift_yFit_1 = polyval(drift_coeff_1, drift_x);
drift_yFit_2 = polyval(drift_coeff_2, drift_x);

drift_1 = drift_coeff_1(1) * fs * 3600;
drift_2 = drift_coeff_2(1) * fs * 3600;

disp(drift_1)
disp(drift_2)

calculated_relative_drift = drift_1 - drift_2;
disp(calculated_relative_drift)