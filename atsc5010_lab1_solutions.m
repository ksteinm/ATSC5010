%% Question 1
    % Name the file atsc5010_lastname_Lab1

%% Question 2
    % Read in the 5 variables

% Liquid water content from the cloud droplet probe
LWC_CDP = ncread('atsc5010_lab1.nc', 'LWC_CDP'); % [g/m^3]

% Liquid water content from the particle volume monitor probe
LWC_PVM = ncread('atsc5010_Lab1.nc', 'LWC_PVM'); % [g/m^3]

% Droplet number concentration from the cloud droplet probe
N_CDP = ncread('atsc5010_Lab1.nc', 'N_CDP'); % [#/cm^3]

% Droplet number concentration from the forward scattering spectrometer probe
N_FSSP = ncread('atsc5010_Lab1.nc', 'N_FSSP'); % [#/cm^3]

% Vertical velocity
W_Wind = ncread('atsc5010_Lab1.nc', 'WWIND'); % [m/s]

%% Question 3
    % Building two arrays to represent the distance from the center of the cloud

% Creating variable for the 10 Hz data
Dist_10Hz = linspace(-5, 5, 1001);

% Creating variable for the 25 Hz data
Dist_25Hz = linspace(-5, 5, 2501);

%% Plot 1, 2, and 3
    % Question 1 throught 20

figure
% Plot 1 ------------------------------------------------
subplot(3, 1, 1)
% Plot LWC_PVM as a function of distance from center of cloud
plot(Dist_10Hz, LWC_PVM, 'g')
hold on
% Plot LWC_CDP as a function of distance from center of cloud
plot(Dist_10Hz, LWC_CDP, 'r')
hold off
% Setting font size - Not needed for lab
set(gca, 'FontSize', 15)
% Set axis limits
% Y-axis limits
ylim([0 3])
% X-axis limits
xlim([-5 5])
% Axis and plot title
% X-axis label
xlabel('Distance from Center of Cloud (km)', 'FontSize', 15)
% Y-axis label
ylabel('H_2O (gm^-^3)', 'FontSize', 15)
% Plot title
title('Cloud Liquid Water Content', 'FontSize', 20)
% Add legend on left side of plot
legend({'PVM', 'CDP'}, 'Location', 'northwest')

% Plot 2 ---------------------------------------------
subplot(3, 1, 2)
% Plot N_FSSP as a function of distance from center of cloud
plot(Dist_10Hz, N_FSSP, 'C')
hold on
% Plot N_CDP as a function of distance from center of cloud
plot(Dist_10Hz, N_CDP, 'r')
hold off
% Setting font size - Not needed for lab
set(gca, 'FontSize', 15)
% Question  12 - Set x-axis limits
% X-axis limits
xlim([-5 5])
% Axis and plot titles
% X-axis label
xlabel('Distance from Center of Cloud (km)', 'FontSize', 15)
% Y-axis label
ylabel('Number Concentration', 'FontSize', 15)
% Plot title
title('Cloud Concentration Number', 'FontSize', 20)
% Add legend on right side of plot
legend({'FSSP', 'CDP'}, 'Location', 'northeast')

% Plot 3 ---------------------------------------------
% Smooth vertical wind speed
W_Wind_smooth = smooth(W_Wind, 25);

% Find where the smoothed vertical wind speed is greater than 12 m/s
W_Wind_smooth_12 = find(W_Wind_smooth > 12);

% Creating arrays for the zero line
Fives = [-5 5];
Zero = [0 0];

subplot(3, 1, 3)
% Plot vertical velocity as a function of distance from center of cloud
plot(Dist_25Hz, W_Wind, 'r')
hold on
% Plot smoothed vertical wind speed
plot(Dist_25Hz, W_Wind_smooth, 'b', 'LineWidth', 2)
% Plotting where the smoothed vertical wind speed is greater than 12 m/s
plot(Dist_25Hz(W_Wind_smooth_12), W_Wind_smooth(W_Wind_smooth_12), 'g', 'LineWidth', 2)
% Plot the zero line
plot(Fives, Zero, '--k')
hold off
% Setting font size - Not needed for lab
set(gca, 'FontSize', 15)
% Set axis limits
% Y-axis limits
ylim([-10 20])
% X-axis limits
xlim([-5 5])
% Add axis and plot titles
% X-axis label
xlabel('Distance from Center of Cloud (km)', 'FontSize', 15)
% Y-axis label
ylabel('Vertical Wind Speed (m/s)', 'FontSize', 15)
% Plot title
title('Cloud Vertical Wind Speed', 'FontSize', 20)

%% Plot 4
    % Question 21 through 29

% Find where LWC is greater than 0.02 g/m^3
LWC_index = find(LWC_CDP > 0.02 & LWC_PVM > 0.02);

% Create a one-to-one line
X_ones = [0 2.5];
Y_ones = [0 2.5];

% Calculate the best fit line
LWC_fit = polyfit(LWC_CDP(LWC_index), LWC_PVM(LWC_index), 1);

%  X-axis coordinates associated with the best fit line
x_fit = [0 2.5];

% Calculating the y-axis coordinates of the best fit line
y_fit = x_fit .* LWC_fit(1) + LWC_fit(2);

% Compute the correlation coefficient
LWC_rho = corrcoef(LWC_CDP(LWC_index), LWC_PVM(LWC_index));

% Compute the correlation coefficient
txt = ['\rho = ', num2str(LWC_rho(1, 2))];

figure
% Plot the one-to-one line
plot(X_ones, Y_ones, 'k', 'LineWidth', 2) % Line width was not necessary for lab
hold on
% Plot the best fit line
plot(x_fit, y_fit, 'r', 'LineWidth', 4)
% Plot LWC_PVM greater than 0.02 as a function of LWC_CDP greater than 0.02
plot(LWC_CDP(LWC_index), LWC_PVM(LWC_index), 'dr', 'MarkerFaceColor', [1 0 0])
hold off
% Setting font size - Not needed for lab
set(gca, 'FontSize', 15)
% X-axis limits
xlim([0 2.5])
% Y-axis limits
ylim([0 2.5])
% Add the correlation coefficient to the plot
text(0.05, 2.25, txt, 'FontSize', 20)
% Legend
legend({'1-to-1 line', 'Best Fit'}, 'Location', 'southeast')
% X-axis label
xlabel('CDP Liquid Water Content', 'FontSize', 15)
% Y-axis label
ylabel('PVM Liquid Water Content', 'FontSize', 15)
% Plot title
title('LWC Probe Comparision', 'FontSize', 20)

%% Plot 5
    % Question 30

% Find where number concentration is greater than 1 m^-3
N_index = find(N_CDP > 1 & N_FSSP > 1);

% Create a one-to-one line
X_ones_N = [0 400];
Y_ones_N = [0 400];

% Calculate the best fit line
N_fit = polyfit(N_FSSP(N_index), N_CDP(N_index), 1);

%  X-axis coordinates associated with the best fit line
x_fit_N = [0 400];

% Calculating the y-axis coordinates of the best fit line
y_fit_N = x_fit_N .* N_fit(1) + N_fit(2);

% Compute the correlation coefficient
n_rho = corrcoef(N_FSSP(N_index), N_CDP(N_index));

% Creating a text ariable
txt_N = ['\rho = ', num2str(n_rho(1, 2))];


figure
% Plot the one-to-one line
plot(X_ones_N, Y_ones_N, 'k', 'LineWidth', 2) % Line width was not necessary for lab
hold on
% Plot the best fit line
plot(x_fit_N, y_fit_N, 'r', 'LineWidth', 4)
% Plot N_FSSP greater than 0.02 as a function of N_CDP greater than 0.02
plot(N_FSSP(N_index), N_CDP(N_index), 'dr', 'MarkerFaceColor', [1 0 0])
hold off
% Setting font size - Not needed for lab
set(gca, 'FontSize', 15)
% X-axis limits
xlim([0 400])
% Y-axis limits
ylim([0 400])
% Add the correlation coefficient to the plot
text(10, 350, txt_N, 'FontSize', 20)
% Legend
legend({'1-to-1 line', 'Best Fit'}, 'Location', 'southeast')
% X-axis label
xlabel('FSSP Number Concentration', 'FontSize', 15)
% Y-axis label
ylabel('CDP Number Concentration', 'FontSize', 15)
% Plot title
title('Number Concentration Probe Comparision', 'FontSize', 20)




