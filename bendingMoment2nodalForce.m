function N_kgf = bendingMoment2nodalForce(moment_kNm, rad_twr_cm, file_coords, degree)
%CONVERTBENDINGMOMENT Summary of this function goes here
%   Detailed explanation goes here

coords = readtable(file_coords);

moment_kgfcm = moment_kNm * 1000 / 9.8 * 100;
sum_X = sum(coords{:, 2} .^2);
p = moment_kgfcm / sum_X * rad_twr_cm;

coords_updated = table();
coords_updated.X = coords{:, 2} .* cos(deg2rad(degree)) - coords{:, 3} .* sin(deg2rad(degree));
coords_updated.Y = coords{:, 2} .* sin(deg2rad(degree)) + coords{:, 3} .* cos(deg2rad(degree));

N_kgf = p .* coords_updated.X / rad_twr_cm;
end
