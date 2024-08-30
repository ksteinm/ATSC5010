%% Constant Values

% Universal gas constant for dry air
Rd = 287; % [J/(Kg*K)]

% Specific heat capacity at a constant pressure
Cp = 1004; % [J/(Kg*K)]

%% Creating the Temperature and Pressure Variables

% Temperature
Temperature = -30:0.1:30; % [Degrees Celcius]

% Converting the temperature from celcius to Kelvin
Temp_K = Temperature + 273.15; % [K]

% Pressure 
Pressure = 200:1:1000; % [hPa]

% Determining the length of the variables
Temp_length = length(Temperature);
Press_length = length(Pressure);

%% Calcularing Potential Temperature

% Creating a 2D potential temperature variable
PotTemp = NaN(Press_length, Temp_length);

% Loop 1 => goes through the length of the pressure variable
for i = 1:Press_length
    % Loop 2 =? goes through the length of the temperature array
    for k = 1:Temp_length
        % Calculating potential temperature
        PotTemp(i, k) = Temp_K(k) .* ((1000 ./ Pressure(i)) .^ (Rd./Cp)); % [K]
    end
end

%% Creating Emagram Plot

% Potential temperature lines for plot
PotTemp_Contour = 250:10:470;
% Contour labels
Contour_label = 260:20:460;

figure
% Creating a contour plot for potential temperature
[c, h] = contour(Temperature, Pressure, PotTemp, PotTemp_Contour, 'color', [0.4660 0.6740 0.1880]);
% Creating inline contour label
clabel(c, h, Contour_label, 'color', [0.4660 0.6740 0.1880])
% Creating a log scale y-axis scale
set(gca, 'YScale', 'log')
% Setting y-axis scale limits
ylim([200 1000])
% Setting y-axis ticks
yticks([200 300 400 500 600 700 800 900 1000])
% Inverting y-axis scale
set(gca, 'YDir','reverse')
% X-axis lable
xlabel('Temperautre ({\circ}C)', 'FontSize', 20)
% Y-axis label
ylabel('Pressure (hPa)', 'FontSize', 20)
% Plot title
title('ATSC 5010 Lab 3: Emagram', 'FontSize', 30)
% Turning on plot grid
grid on
% Naming the plot grid
ax = gca;
% Making grid lines dotted
ax.GridLineStyle = ':';


