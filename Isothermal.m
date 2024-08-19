function [Iso_height] = Isothermal(Pressure, z0, t0, p0, rd, g)
    % Creating an empty array
    Iso_height = NaN(size(Pressure));
    % Loop to run through all data
    for i = 1:length(Pressure)
        % Isothermal equation
        z = z0 + ((rd .* t0) ./ g) .* (log(p0 ./ Pressure(i)));
        Iso_height(i) = z;
    end
end