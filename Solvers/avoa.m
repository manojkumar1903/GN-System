function [bestPosition, bestFitness] = africanVultureOptimization(fitnessFunction, numVultures, dim, iterMax)
    lowerBound = -100;
    upperBound = 100;

    positions = lowerBound + (upperBound - lowerBound) * rand(numVultures, dim);
    fitness = arrayfun(@(i) fitnessFunction(positions(i,:)), 1:numVultures);
    [bestFitness, bestIdx] = min(fitness);
    bestPosition = positions(bestIdx, :);

    for t = 1:iterMax
        for i = 1:numVultures
            r1 = rand();
            r2 = rand();

            if r1 < 0.5
                A = 2 * r2 - 1;
                positions(i, :) = positions(i, :) + A * abs(bestPosition - positions(i, :));
            else
                C = 2 * r2;
                positions(i, :) = bestPosition - C * abs(bestPosition - positions(i, :));
            end

            positions(i, :) = max(positions(i, :), lowerBound);
            positions(i, :) = min(positions(i, :), upperBound);

            newFitness = fitnessFunction(positions(i, :));
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
