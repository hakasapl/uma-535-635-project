close all

% Plot Example Raw data
figure
hold on
plot(out_values(1:6000,1))
plot(out_values(1:6000,2))
xlabel("Samples")
ylabel("Pressure (mB)")

% Plot Example XCorr
figure
plot(cur_corr)
xlabel("Samples")
ylabel("Magnitude")

% Plot Drift over Time
figure
hold on
plot(offset_vec)
plot(drift_xFit,drift_yFit)
legend("Time Offset", "Linear Regression")
xlim([1,offset_vec_size])
xlabel("Sample Windows (6000 Samples)")
ylabel("Time Offset (s)")
