function setFigureMargins(leftMarginCm, bottomMarginCm, rightMarginCm, topMarginCm)
%% Description: Control the figure margin with this function
% Enables to fill all the space in the figure

% Lorenzo Nicoletti, 07.01.2025 Munich, Germany

% Example: setFigureMargins(2, 1.1, 0.1, 0.1)


    % Convert cm to normalized figure units
    figureHandle = gcf; % Get current figure handle
    figureUnits = get(figureHandle, 'Units');
    set(figureHandle, 'Units', 'centimeters');
    figPos = get(figureHandle, 'Position'); % [left, bottom, width, height] in cm
    
    % Calculate normalized margins
    leftMarginNormalized = leftMarginCm / figPos(3);
    bottomMarginNormalized = bottomMarginCm / figPos(4);
    rightMarginNormalized = rightMarginCm / figPos(3);
    topMarginNormalized = topMarginCm / figPos(4);
    
    % Calculate new axes position
    newAxesPos = [leftMarginNormalized, bottomMarginNormalized, ...
                  1 - leftMarginNormalized - rightMarginNormalized, ...
                  1 - bottomMarginNormalized - topMarginNormalized];
    
    % Adjust current axes
    ax = gca;
    set(ax, 'Position', newAxesPos);
    
    % Restore the figure units
    set(figureHandle, 'Units', figureUnits);
end
