function [bestPosition, bestFitness] = slimeMouldOptimization(fitnessFunction, numSlimes, dim, iterMax)
    lowerBound = -100; % Define according to your problem
    upperBound = 100;  % Define according to your problem

    % Initialize slime mould positions
    positions = lowerBound + (upperBound - lowerBound) * rand(numSlimes, dim);

    % Evaluate initial population
    fitness = arrayfun(@(i) fitnessFunction(positions(i,:)), 1:numSlimes);
    [bestFitness, bestIdx] = min(fitness);
    bestPosition = positions(bestIdx, :);

    % Slime Mould Algorithm main loop
    for t = 1:iterMax
        for i = 1:numSlimes
            % Update position
            for j = 1:dim
                if rand() < 0.5
                    positions(i, j) = positions(i, j) + rand() * (bestPosition(j) - positions(i, j));
                else
                    positions(i, j) = positions(i, j) - rand() * (bestPosition(j) - positions(i, j));
                end
            end

            % Boundary check
            positions(i, :) = max(positions(i, :), lowerBound);
            positions(i, :) = min(positions(i, :), upperBound);

            % Evaluate new solutions
            newFitness = fitnessFunction(positions(i, :));

            % Update if the new solution is better
            if newFitness < fitness(i)
                fitness(i) = newFitness;
                if newFitness < bestFitness
                    bestFitness = newFitness;
                    bestPosition = positions(i, :);
                end
            end
        end
    end
end
