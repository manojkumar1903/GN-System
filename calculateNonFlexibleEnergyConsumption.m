function E_non_flexible = calculateNonFlexibleEnergyConsumption(P, H)

    if size(H, 2) ~= length(P)
        error('The number of columns in H must match the length of P.');
    end

    % Calculate the energy consumption
    E_non_flexible = sum(sum(P .* H));
end
    % calculateNonFlexibleEnergyConsumption calculates the energy consumption for non-flexible appliances.
    %
    % Inputs:
    %   P - Vector of power ratings for each appliance (Pr)
    %   H - Matrix of operational hours, where each row corresponds to a time slot (t)
    %       and each column to an appliance (r) (Ht,r)
    %
    % Output:
    %   E_non_flexible - Total energy consumption for non-flexible appliances

    % Ensure that the input matrix H matches the length of P