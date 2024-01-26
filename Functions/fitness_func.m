function energyManagementModel

    function E_flexible = calculateFlexibleEnergyConsumption(P, H, b, U)
        E_flexible = sum(sum(P .* H .* b .* U));
    end

    function E_non_flexible = calculateNonFlexibleEnergyConsumption(P, H)
        E_non_flexible = sum(sum(P .* H));
    end

    function R_base = calculateResidentialBaseLoad(P_flexible, H_flexible, b, U, P_non_flexible, H_non_flexible)
        E_flexible = calculateFlexibleEnergyConsumption(P_flexible, H_flexible, b, U);
        E_non_flexible = calculateNonFlexibleEnergyConsumption(P_non_flexible, H_non_flexible);
        R_base = E_flexible + E_non_flexible;
    end

    function I_base = calculateITSectorBaseLoad(Pc, Hc, E_flexible_IT)
        E_non_flexible_IT = sum(Pc .* Hc);
        I_base = E_non_flexible_IT + E_flexible_IT;
    end

    function S_solar = calculateSolarGeneration(C_solar, eta_solar, S_t, delta_t)
        S_solar = C_solar * eta_solar * S_t * delta_t;
    end

    function E_EV = calculateEVChargingLoad(P_EV, c_t_EV)
        E_EV = sum(P_EV .* c_t_EV);
    end

    function R_total = calculateResidentialTotalLoad(R_base, E_EV, S_solar)
        R_total = R_base + E_EV - S_solar;
    end

    function I_total = calculateITSectorTotalLoad(I_base, IT_EV_Load, IT_Solar_Generation)
        I_total = I_base + IT_EV_Load - IT_Solar_Generation;
    end

    function F = ObjectiveFunction(D_peak, R_t, I_t)
        F = D_peak - (R_t + I_t);
    end

end
