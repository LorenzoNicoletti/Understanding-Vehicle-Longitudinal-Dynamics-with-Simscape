%% Description: Plot Impact of Inertia, Mass and Drag coefficient
% This function shows the impact of the inertia, mass, and drag coefficient
% on the maximum attainable speed of a vehicle. While the torque at the
% wheels remains constant, mass, inertia and drag coefficient are changed. 

% Lorenzo Nicoletti, 07.01.2025 Munich, Germany

%% Implementation:
% Model name to be used for the simulation
modelName = 'vehicleModelBodyAndTires';
open_system(modelName);
close all;

%% 1) Simulate vehicle with default parametrization
% Load default parameters
setVehicleParam;

% Collect results in variable simOutDef
simOutDef = sim(modelName);

%% 2) Simulate impact of tire inertia
% Simulate with higher inertia on the wheels (factor 2). Collect results in simOutInert
wheelInertia = wheelInertia*2;
simOutInert = sim(modelName);

% Plot results
figure('Units','centimeters','Position',[0,0,23.64,13.05],'Color','w'); hold on; grid on;
plot(simOutDef.simlog.Vehicle.V.series.time/60,simOutDef.simlog.Vehicle.V.series.values('m/s')*3.6,...
     'LineWidth',2,'Color','b','DisplayName','Wheel Inertia = 1 kgm^2');

plot(simOutInert.simlog.Vehicle.V.series.time/60, simOutInert.simlog.Vehicle.V.series.values('m/s')*3.6,...
    'LineWidth',2,'Color','r','DisplayName','Wheel Inertia = 2 kgm^2');

% Set axes labels:
xlabel('Time in min'); ylabel('Vehicle Speed in km/h');
ax = gca; ax.FontSize = 14;
setFigureMargins(1.9, 1.5, 0.4, 0.2);
legend('Location','best');

%% 3) Simulate impact of vehicle mass
% Reset default parameters
setVehicleParam;

% Simulate with higher mass of the vehicle (100 kg). Collect results in simOutInert
vehicleMass = vehicleMass+100;
simOutMass = sim(modelName);

% Plot results
figure('Units','centimeters','Position',[0,0,23.64,13.05],'Color','w'); hold on; grid on;
plot(simOutDef.simlog.Vehicle.V.series.time/60,simOutDef.simlog.Vehicle.V.series.values('m/s')*3.6,...
     'LineWidth',2,'Color','b','DisplayName','Vehicle Mass = 1500');

plot(simOutMass.simlog.Vehicle.V.series.time/60,simOutMass.simlog.Vehicle.V.series.values('m/s')*3.6,...
    'LineWidth',2,'Color','r','DisplayName','Vehicle Mass = 1600');

% Set axes labels
xlabel('Time in min'); ylabel('Vehicle Speed in km/h');
ax = gca; ax.FontSize = 14;
setFigureMargins(1.9, 1.5, 0.4, 0.2);
legend('Location','best');

%% 4) Simulate impact of drag coefficient
% Reset default parameters
setVehicleParam;

% Simulate with higher mass of the vehicle (250 kg). Collect results in simOutInert
vehicleCD = vehicleCD*1.5;
simOutCD  = sim(modelName);

% Plot results
fig = figure('Units','centimeters','Position',[0,0,23.64,13.05],'Color','w'); hold on; grid on;
plot(simOutDef.simlog.Vehicle.V.series.time/60,simOutDef.simlog.Vehicle.V.series.values('m/s')*3.6,...
     'LineWidth',2,'Color','b','DisplayName','c_D = 0.23');

plot(simOutCD.simlog.Vehicle.V.series.time/60,simOutCD.simlog.Vehicle.V.series.values('m/s')*3.6,...
     'LineWidth',2,'Color','r','DisplayName','c_D = 0.35');

% Set axes labels
xlabel('Time in min'); ylabel('Vehicle Speed in km/h');
ax = gca; ax.FontSize = 14;
setFigureMargins(1.9, 1.5, 0.4, 0.2);
legend('Location','best');