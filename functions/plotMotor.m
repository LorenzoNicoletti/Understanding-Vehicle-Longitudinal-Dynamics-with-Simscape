%% Description
% This function shows the impact of the motor characteristics on the
% maximum speed of the vehicle

% Lorenzo Nicoletti, 07.01.2025 Munich, Germany

%% Implementation
% Model name to be used for the simulation
modelName1 = 'vehicleModelGearbox';
modelName2 = 'vehicleModelMotor';
open_system(modelName1);
open_system(modelName2);
close all;

%% 1) Simulate vehicle with the gearbox model
% Load default parameters
setVehicleParam;

% Collect results in variable simOutGrbx
simOutGrbx = sim(modelName1);

%% 2) Simulate the vehicle with the additional motor effects
% Collect results in variable simOutMotr
simOutMotr = sim(modelName2);

%% 3) Plot Maximum Speed for the two cases
% Plot speed comparison with the two different gearbox ratio
figure('Units','centimeters','Position',[0,0,23.64,13.05],'Color','w'); hold on; grid on;
plot(simOutGrbx.simlog.Vehicle.V.series.time/60,simOutGrbx.simlog.Vehicle.V.series.values('m/s')*3.6,...
     'LineWidth',2,'Color','r','DisplayName','Without Machine');

plot(simOutMotr.simlog.Vehicle.V.series.time/60,simOutMotr.simlog.Vehicle.V.series.values('m/s')*3.6,...
    'LineWidth',2,'Color','b','DisplayName','With Machine');

% Axes Labels
xlabel('Time in min'); ylabel('Vehicle Speed in km/h');
ax = gca; ax.FontSize = 14;
setFigureMargins(1.9, 1.5, 0.4, 0.2);
legend('Location','best');

%% 4) Plot Torque comparison of the two models
% Plot torque comparison between model with and without electric machine
figure('Units','centimeters','Position',[0,0,23.64,13.05],'Color','w'); hold on; grid on;
plot(simOutGrbx.simlog.Vehicle.V.series.time/60,simOutGrbx.simlog.Gearbox.tB.series.values('N*m'),...
     'LineWidth',2,'Color','r','DisplayName','Without Machine');

plot(simOutMotr.simlog.Vehicle.V.series.time/60,simOutMotr.simlog.Gearbox.tB.series.values('N*m'),...
    'LineWidth',2,'Color','b','DisplayName','With Machine');

% Axes Labels
xlabel('Time in min'); ylabel('Input Torque Gearbox in N*m');
ax = gca; ax.FontSize = 14;
setFigureMargins(1.9, 1.5, 0.4, 0.2);
legend('Location','best');