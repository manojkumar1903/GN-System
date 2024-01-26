function constraintsSatisfied = checkConstraints(params)
    % Extract parameters from 'params' structure
    peakHours = params.peakHours;
    EVChargingStatus = params.EVChargingStatus;
    minimumSoC = params.minimumSoC;
    currentSoC = params.currentSoC;
    nonPeakHours = params.nonPeakHours;
    emergencyHours = params.emergencyHours;
    solarGeneration = params.solarGeneration;
    loadShiftPotential = params.loadShiftPotential;
    maxLoad = params.maxLoad;
    minLoad = params.minLoad;
    totalEnergyConsumption = params.totalEnergyConsumption;
    energyConsumptionTarget = params.energyConsumptionTarget;

    % EV Charging Schedule Constraints
    if any(EVChargingStatus(peakHours) == 1)
        constraintsSatisfied = false;
        return;
    end

    % Minimum State of Charge for EVs
    if any(currentSoC < minimumSoC)
        constraintsSatisfied = false;
        return;
    end

    % Non-Peak Charging Windows
    if ~all(EVChargingStatus(nonPeakHours) == 1) && ~all(EVChargingStatus(emergencyHours) == 1)
        constraintsSatisfied = false;
        return;
    end

    % Solar Generation Constraints
    if solarGeneration <= 0
        constraintsSatisfied = false;
        return;
    end

    % Load Shifting
    if ~loadShiftPotential
        constraintsSatisfied = false;
        return;
    end

    % Maximum and Minimum Load Levels
    if any(params.loads > maxLoad) || any(params.loads < minLoad)
        constraintsSatisfied = false;
        return;
    end

    % Total Daily Energy Consumption
    if totalEnergyConsumption > energyConsumptionTarget
        constraintsSatisfied = false;
        return;
    end

    % If all constraints are satisfied
    constraintsSatisfied = true;
end
