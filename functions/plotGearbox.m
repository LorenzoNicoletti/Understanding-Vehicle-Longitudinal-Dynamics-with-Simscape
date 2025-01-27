%% Description
% This function shows the impact of the gearbox ratio on the maximum speed
% of the vehicle. The vehicle always has the same input torque at the
% gearbox and the transmission ratio will be decreased to observe how this
% impacts the maximum attainable vehicle speed. 

% Lorenzo Nicoletti, 07.01.2025 Munich, Germany

%% Implementation:
% Model name to be used for the simulation
modelName = 'vehicleModelGearbox';
open_system(modelName);
close all;

%% 1) Simulate vehicle with default parametrization
% Load default parameters
setVehicleParam;

% Collect results in variable simOutDef
simOutDef = sim(modelName);

%% 2) Simulate vehicle with different transmission ratio:
% Modify the default transmission ratio
gearboxRatio = gearboxRatio-2;

% Collect results in simOutRatio
simOutRatio = sim(modelName);

%% 3) Plot maximum vehicle speed
% Plot speed comparison with the two different gearbox ratio
figure('Units','centimeters','Position',[0,0,23.64,13.05],'Color','w'); hold on; grid on;
plot(simOutDef.simlog.Vehicle.V.series.time/60,simOutDef.simlog.Vehicle.V.series.values('m/s')*3.6,...
     'LineWidth',2,'Color','b','DisplayName','i = 7');

plot(simOutRatio.simlog.Vehicle.V.series.time/60,simOutRatio.simlog.Vehicle.V.series.values('m/s')*3.6,...
    'LineWidth',2,'Color','r','DisplayName','i = 5');

% Axes Labels
xlabel('Time in min'); ylabel('Vehicle Speed in km/h');
ax = gca; ax.FontSize = 14;
setFigureMargins(1.9, 1.5, 0.4, 0.2);
legend('Location','best');