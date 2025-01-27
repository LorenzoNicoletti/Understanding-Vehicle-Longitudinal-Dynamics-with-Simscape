%% Description: Parametrization script
% This script sets up the Parametrization for all models contained in the
% project. The current parameters are set to represent a mid-size electric vehicle

% Lorenzo Nicoletti, 07.01.2025 Munich, Germany

% NB: Depending on which model you are using, some parameters might be unused

%% Vehicle Dimensions
vehicleMass  = 1500;      % Mass in kg
vehicleSurf  = 2.24;      % Surface in m^2 
vehicleCD    = 0.23;      % Drag coefficient 
vehicleCOGFA = 2.875*0.5; % Distance between COG and Front Axle. Assume a 50/50 distribution and a wheelbase of 2875 mm
vehicleCOGRA = 2.875*0.5; % Distance between COG and Front Axle. Assume a 50/50 distribution and a wheelbase of 2875 mm

%%  Wheel Parameters 
wheelRadius    = 0.336;   % Wheel radius in m
wheelcR        = 0.015;   % Rolling coefficient (unitless)
wheelInertia   = [1, 0.3];% Wheel and rim inertia in kg*m^2 
wheelSpeedStart= 0;       % Starting speed of the wheel in rad/s

%% Gearbox Parameters
gearboxRatio    = 7;      % Gearbox ratio
gearboxEff      = 0.98;   % Gearbox efficiency

%% Electric Machine Parameters
% Machine characteristics (maximum torque in Nm over speed in rad/s)
EMTorque    = [450 450 450 450 450 377.79404616438654 302.23523693150923 251.8626974429244 215.88231209393518 188.89702308219327 167.90846496194959 151.11761846575462 137.37965315068604 125.9313487214622]/2;
EMSpeed     = [0 139.62634015954637 279.25268031909275 418.87902047863906 468.88888888888891 558.50536063818549 698.13170079773181 837.75804095727813 977.38438111682456 1117.010721276371 1256.6370614359173 1396.2634015954636 1535.88974175501 1675.5160819145563];

% Machine efficiency (look up able of efficiency in dependency of the torque in Nm and speed in rad/s)
EMTorqueEff = [0 45 90 135 180 225 270 315 360 405 450]/2;
EMSpeedEff  = EMSpeed;
EMEffMap    = [50 78 80 82 82 80 78 78 76 74 70;52 78 80 82 82 80 78 78 76 74 70;52 78 84 86 86 86 86 84 84 82 82;52 80 86 86 88 88 88 86 86 84 84;52 80 86 88 88 88 88 88 86 86 86;52 80 86 88 90 90 90 90 88 88 88;52 82 88 90 91 91 92 92 92 91 91;52 82 88 91 91 92 93 93 93 93 93;52 84 90 92 92 93 93 93 93 93 93;62 86 91 93 93 93 93 93 93 93 93;66 86 91 93 93 93 93 93 93 93 93;70 86 92 93 93 93 93 93 93 93 93;70 86 92 93 93 93 93 93 93 93 93;72 86 91 93 93 93 93 93 93 93 93];