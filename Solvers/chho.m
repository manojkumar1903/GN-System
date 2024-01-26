function [bestHawk, bestFitness] = chaoticHarrisHawkOptimization(fitnessFunction, numHawks, dim, iterMax)
    % Initialize parameters
    lowerBound = -100; % Define according to  problem
    upperBound = 100;  % Define according to  problem

    % Initialize hawk positions
    hawks = lowerBound + (upperBound - lowerBound) * rand(numHawks, dim);

    % Evaluate initial population
    fitness = arrayfun(@(i) fitnessFunction(hawks(i,:)), 1:numHawks);
    [bestFitness, bestIdx] = min(fitness);
    bestHawk = hawks(bestIdx, :);

    % Chaotic Harris Hawk Optimization main loop
    for t = 1:iterMax
        for i = 1:numHawks
            r = rand(); % Random number for exploration and exploitation
            q = rand(); % Random number for position update
            L = 1.5 * randn(1, dim); % Levy flight random number

            % Update position
            if r >= 0.5 && abs(bestFitness - fitness(i)) > 1e-6
                % Exploitation phase
                hawks(i, :) = bestHawk - q * abs(bestHawk - hawks(i, :));
            else
                % Exploration phase
                hawks(i, :) = bestHawk + L .* (lowerBound + (upperBound - lowerBound) * rand(1, dim));
            end

            % Boundary check
            hawks(i, :) = max(hawks(i, :), lowerBound);
            hawks(i, :) = min(hawks(i, :), upperBound);

            % Evaluate new solutions
            newFitness = fitnessFunction(hawks(i, :));

            % Update if the new solution is better
            if newFitness < fitness(i)
                fitness(i) = newFitness;
                if newFitness < bestFitness
                    bestFitness = newFitness;
                    bestHawk = hawks(i, :);
                end
            end
        end
    end
end
