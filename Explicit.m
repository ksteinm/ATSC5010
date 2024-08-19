function [Expo_height] = Explicit(z0, Pressure, Temp, rd, g)
    % Creating an empty array
    Expo_height = NaN(size(Pressure));
    Expo_height(1) = z0;
    % Loop to start at index 2 and run until the end of the variables
    for i = 2:length(Pressure)
        % Calculating average temperature
        Tavg = (Temp(i - 1) + Temp(i)) ./ 2;
        % Calculating average pressure
        Pavg = (Pressure(i - 1) + Pressure(i)) ./ 2;
        % Explicit equation
        z = Expo_height(i - 1) + ((rd / g) .* Tavg .* (1 ./ Pavg) .* (Pressure(i - 1) - Pressure(i)));
        Expo_height(i) = z;
    end
end