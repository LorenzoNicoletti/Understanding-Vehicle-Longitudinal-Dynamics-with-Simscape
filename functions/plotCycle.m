%% Description
% This script simulates a closed-loop vehicle model in two drive cycle
% (FTP75 and WLTP) and compares the consumption of tires, vehicle and
% powertrain. The results can be represented as a bar plot or a simple
% table. 

% Lorenzo Nicoletti, 07.01.2025 Munich, Germany

% NB: To simulate both cycle you need to install the Powertrain Blockset Drive Cycle Data: https://www.mathworks.com/matlabcentral/fileexchange/59683-powertrain-blockset-drive-cycle-data

%% Implementation
% Model name to be used for the simulation
modelName = 'vehicleModelDriveCycle';

% open and load the model:
open_system(modelName);

% Drive cycle block path where we can change the drive cycle 
driveCycleBlockPath  = [modelName,'/Cycle/Cycle Source'];

close all;

%% 1) Simulate a FTP75 drive cycle:
% Set drive cycle and simulation time
set_param(driveCycleBlockPath,'cycleVar','FTP75');

% Collect results in variable simFTP
simFTP = sim(modelName,'StopTime','2474');

%% 2) Simulate the vehicle with the additional motor effects
% Set drive cycle and simulation time
set_param(driveCycleBlockPath,'cycleVar','WLTP Class 3');

% Collect results in variable simWLTP
simWLTP = sim(modelName,'StopTime','1800');

%% 3) Postprocessing: Compare the energy losses
% Cumulative energy losses for the FTP75 cycle
simTimeFTP     = simFTP.tout;
lossesFTP(:,1) = cumtrapz(simTimeFTP, simFTP.simlog.Plant_Model.Vehicle.power_dissipated.series.values('W'))/3600/1000;
lossesFTP(:,2) = cumtrapz(simTimeFTP, simFTP.simlog.Plant_Model.Rear_Wheel_Left.resistance.power_dissipated.series.values('W'))*2/3600/1000 + ...
                 cumtrapz(simTimeFTP, simFTP.simlog.Plant_Model.Front_Wheel_Left.resistance.power_dissipated.series.values('W'))*2/3600/1000;
lossesFTP(:,3) = cumtrapz(simTimeFTP, simFTP.simlog.Plant_Model.Gearbox.power_dissipated.series.values('W'))/3600/1000;
lossesFTP(:,4) = cumtrapz(simTimeFTP, simFTP.simlog.Plant_Model.Motor.power_dissipated.series.values('W'))/3600/1000;

% Cumulative energy losses for the WLTP cycle
simTimeWLTP     = simWLTP.tout;
lossesWLTP(:,1) = cumtrapz(simTimeWLTP, simWLTP.simlog.Plant_Model.Vehicle.power_dissipated.series.values('W'))/3600/1000;
lossesWLTP(:,2) = cumtrapz(simTimeWLTP, simWLTP.simlog.Plant_Model.Rear_Wheel_Left.resistance.power_dissipated.series.values('W'))*2/3600/1000 + ...
                  cumtrapz(simTimeWLTP, simWLTP.simlog.Plant_Model.Front_Wheel_Left.resistance.power_dissipated.series.values('W'))*2/3600/1000;
lossesWLTP(:,3) = cumtrapz(simTimeWLTP, simWLTP.simlog.Plant_Model.Gearbox.power_dissipated.series.values('W'))/3600/1000;
lossesWLTP(:,4) = cumtrapz(simTimeWLTP, simWLTP.simlog.Plant_Model.Motor.power_dissipated.series.values('W'))/3600/1000;

% Represent losses with table
T = array2table([lossesFTP(end,:);lossesWLTP(end,:)], 'VariableNames', {'Drag + Slope', 'Tires', 'Gearbox', 'Motor'});

%% 4) Plot the results as bar plots: 
figure('Units','centimeters','Position',[0,0,23.64,13.05],'Color','w'); hold on; grid on;
bar(table2array(T)'); 
set(gca,'XTick',[1,2,3,4])
set(gca, 'XTickLabel', T.Properties.VariableNames);

% Axes Labels
ylabel('Losses in kWh');
ax = gca; ax.FontSize = 14;
setFigureMargins(1.9, 1.5, 0.4, 0.2);
legend('FTP75','WLTP','Location','best');