function [bestAgent, bestFitness] = chaoticInteractiveAutodidactSchool(fitnessFunction, numAgents, dim, iterMax)
    lowerBound = -100;
    upperBound = 100;

    agents = lowerBound + (upperBound - lowerBound) * rand(numAgents, dim);
    fitness = arrayfun(@(i) fitnessFunction(agents(i,:)), 1:numAgents);
    [bestFitness, bestIdx] = min(fitness);
    bestAgent = agents(bestIdx, :);

    for t = 1:iterMax
        for i = 1:numAgents
            r = 4;
            chaos = r * agents(i, :) .* (1 - agents(i, :));
            learningFactor = rand();
            randomAgentIdx = randi(numAgents);
            while randomAgentIdx == i
                randomAgentIdx = randi(numAgents);
            end
            randomAgent = agents(randomAgentIdx, :);
            newAgent = agents(i, :) + learningFactor * (randomAgent - agents(i, :)) + chaos;

            newAgent = max(newAgent, lowerBound);
            newAgent = min(newAgent, upperBound);

            newFitness = fitnessFunction(newAgent);
            if newFitness < fitness(i)
                agents(i, :) = newAgent;
                fitness(i) = newFitness;
                if newFitness < bestFitness
                    bestFitness = newFitness;
                    bestAgent = newAgent;
                end
            end
        end
    end
end
