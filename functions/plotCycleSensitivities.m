%% Description
% This scripts shows the impact of different variable (like mass, drag
% coefficient, and tire rolling resistance on the drag, tire and powertrain
% losses during a drive cycle. As reference for the drive cycle, this
% script uses the WLTP. 

% Lorenzo Nicoletti, 07.01.2025 Munich, Germany

%% Implementation
% Model name to be used for the simulation
modelName = 'vehicleModelDriveCycle';

% open and load the model:
open_system(modelName);

% Get drive cycle block: 
driveCycleBlockPath  = [modelName,'/Cycle/Cycle Source'];

% Set drive cycle to WLTP
set_param(driveCycleBlockPath,'cycleVar','WLTP Class 3');

close all;

%% 1) Simulate impact of an increasing mass on the consumption
% Parametrize the vehicle
setVehicleParam;

% Values of masses used for the sensitivity
massValues = vehicleMass + (0:100:500);

% Simulate each mass value
for i = 1: numel(massValues)

    % Update vehicle mass
    vehicleMass = massValues(i);
    
    % Simulate model
    simout = sim(modelName,'StopTime','1800');
    
    % Postprocess data   
    losses(:,1) = cumtrapz(simout.tout, simout.simlog.Plant_Model.Vehicle.power_dissipated.series.values('W'))/3600/1000;
    losses(:,2) = cumtrapz(simout.tout, simout.simlog.Plant_Model.Rear_Wheel_Left.resistance.power_dissipated.series.values('W'))*2/3600/1000 + ...
                  cumtrapz(simout.tout, simout.simlog.Plant_Model.Front_Wheel_Left.resistance.power_dissipated.series.values('W'))*2/3600/1000;
    losses(:,3) = cumtrapz(simout.tout, simout.simlog.Plant_Model.Gearbox.power_dissipated.series.values('W'))/3600/1000 + ...
                  cumtrapz(simout.tout, simout.simlog.Plant_Model.Motor.power_dissipated.series.values('W'))/3600/1000;
    
    % Collect losses
    lossesTot(i,:) = losses(end,:);
    
    clear losses
end

% Restructure Losses in a table
Tmass = array2table(lossesTot, 'VariableNames', {'Air', 'Tires', 'Powertrain'});

% Display results
disp('Results for vehicle mass variation'); disp(Tmass);

%% 2) Simulate impact of an increasing drag coefficient on the consumption
% Parametrize the vehicle
setVehicleParam;

% Values of cd used for the sensitivity
CDvalues = vehicleCD + (0:0.02:0.1);

% Simulate each cd value
for i = 1: numel(CDvalues)

    % Update cd
    vehicleCD = CDvalues(i);
    
    simout = sim(modelName,'StopTime','1800');
    
    % Postprocess data
    losses(:,1) = cumtrapz(simout.tout, simout.simlog.Plant_Model.Vehicle.power_dissipated.series.values('W'))/3600/1000;
    losses(:,2) = cumtrapz(simout.tout, simout.simlog.Plant_Model.Rear_Wheel_Left.resistance.power_dissipated.series.values('W'))*2/3600/1000 + ...
                          cumtrapz(simout.tout, simout.simlog.Plant_Model.Front_Wheel_Left.resistance.power_dissipated.series.values('W'))*2/3600/1000;
    losses(:,3) = cumtrapz(simout.tout, simout.simlog.Plant_Model.Gearbox.power_dissipated.series.values('W'))/3600/1000 + ...
                  cumtrapz(simout.tout, simout.simlog.Plant_Model.Motor.power_dissipated.series.values('W'))/3600/1000;
    
    % Collect losses
    lossesTot(i,:) = losses(end,:);
    
    clear losses
end

% Restructure Losses in a table
Tcd = array2table(lossesTot, 'VariableNames', {'Air', 'Tires', 'Powertrain'});

% Display results
disp('Results for drag coefficient variation'); disp(Tcd);

%% 3) Simulate impact of a decreasing tire coefficient on the consumption
setVehicleParam;

% Values of cr used for the sensitivity
CRvalues = wheelcR - (0:0.001:0.005);

% Simulate each cr value
for i = 1: numel(CRvalues)

    % Update cr
    wheelcR = CRvalues(i);

    % Simulate model
    simout = sim(modelName,'StopTime','1800');
    
    % Postprocess data
    
    losses(:,1) = cumtrapz(simout.tout, simout.simlog.Plant_Model.Vehicle.power_dissipated.series.values('W'))/3600/1000;
    losses(:,2) = cumtrapz(simout.tout, simout.simlog.Plant_Model.Rear_Wheel_Left.resistance.power_dissipated.series.values('W'))*2/3600/1000 + ...
                  cumtrapz(simout.tout, simout.simlog.Plant_Model.Front_Wheel_Left.resistance.power_dissipated.series.values('W'))*2/3600/1000;
    losses(:,3) = cumtrapz(simout.tout, simout.simlog.Plant_Model.Gearbox.power_dissipated.series.values('W'))/3600/1000 + ...
                  cumtrapz(simout.tout, simout.simlog.Plant_Model.Motor.power_dissipated.series.values('W'))/3600/1000;
    
    % Collect losses
    lossesTot(i,:) = losses(end,:);
    
    clear losses
end

% Restructure data in table 
Tcr = array2table(lossesTot, 'VariableNames', {'Air', 'Tires', 'Powertrain'});

% Display results
disp('Results for tire coefficient variation'); disp(Tcr);