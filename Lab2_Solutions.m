%% Reading in Data

[Time, Time1, Pressure, Temperature, Hu, Ws, Wd, Wsu, Wsv, Height] = readvars('20230908_1918_WyoSonde2.csv');

%% Finding Initial Conditions

T0 = TempK(1);
z0 = Height(1);
P0 = Pressure(1);

%% Constant Variables

% Universal gas constant for dry air
rd = 287.05; % [J/(Kg*K)]

% Acceleration due to gravity
g = 9.81; % [m/s^2]

%% Data Conversions

TempK = Temperature + 273.15; % [K]

%% Isothermal Function

Iso_height = Isothermal(Pressure, z0, T0, P0, rd, g);

%% Explicit Function

Expo_height = Explicit(z0, Pressure, TempK, rd, g);

%% Converting Heights

Iso = Iso_height / 1000; % [km]
Exp = Expo_height / 1000; % [km]

%% Plot 1

figure
% Plot the isothermal model
plot(Pressure, Iso, 'red', 'LineWidth', 2)
hold on
% Plot the explicit model
plot(Pressure, Exp, 'blue', 'LineStyle', '--', 'LineWidth', 2)
hold off
set(gca, 'FontSize', 20)
% Set x-axis limit
xlim([0 1000])
% Invert x-axis
set(gca, 'XDir', 'reverse')
% X-axis label
xlabel('Measured Pressure (mb)', 'FontSize', 20)
% Y-axis label
ylabel('Calculated height (km)', 'FontSize', 20)
% Plot legend
legend({'Isothermal', 'Explicit'}, 'Location', 'northwest')
% Plot title
title('Isothermal Versus Explicit Models', 'FontSize', 30)

%% Plot 2

% Converting height to km
Z = Height ./ 1000; % [km]

figure
% Plot the isothermal model
plot(Iso, Z, 'red', 'LineWidth', 2)
hold on
% Plot the explicit model
plot(Exp, Z, 'blue', 'LineStyle', '--', 'LineWidth', 2)
hold off
set(gca, 'FontSize', 20)
% X-axis label
xlabel('Calculated height (km)', 'FontSize', 20)
% Y-axis label
ylabel('Measured Height (km)', 'FontSize', 20)
% Plot legend
legend({'Isothermal', 'Explicit'}, 'Location', 'northwest')
% Plot Title
title('Calculated Versus Measured Height', 'FontSize', 30)

%% Calculating the Difference Between Calculated and Measured Heights

% Isothermal model
Iso_diff = (Iso - Z) .* 1000; % [m]

% Explicit model
Exp_diff = (Exp - Z) .* 1000; % [m]

%% Plot 3

figure
% Plot the isothermal model
plot(Z, Iso_diff, 'red', 'LineWidth', 2)
hold on
% Plot explicit model
plot(Z, Exp_diff, 'blue', 'LineStyle', '--', 'LineWidth', 2)
hold off
% X-axis label
xlabel('Measured Height (km)', 'FontSize', 20)
% Y-axis label
ylabel('Calculated Height Difference (m)','FontSize', 20)
% Plot legend
legend({'Isothermal', 'Explicit'}, 'Location', 'northwest')
% Plot title
title('Computed Versus Measured Height Differences', 'FontSize', 30)



