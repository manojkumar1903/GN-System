function [bestNest, bestFitness] = cuckooSearch(fitnessFunction, numNests, dim, iterMax, pa)
    % Initialize nests
    lowerBound = -100; % Define according to your problem
    upperBound = 100;  % Define according to your problem
    nests = lowerBound + (upperBound - lowerBound) * rand(numNests, dim);

    % Evaluate initial nests
    fitness = arrayfun(@(i) fitnessFunction(nests(i,:)), 1:numNests);
    [bestFitness, bestIdx] = min(fitness);
    bestNest = nests(bestIdx, :);

    % Cuckoo Search main loop
    for t = 1:iterMax
        for i = 1:numNests
            % Get a cuckoo randomly by Lévy flights
            newNest = nests(i, :) + levyFlights(dim) .* (nests(i, :) - nests(randi(numNests), :));

            % Boundary check
            newNest = max(newNest, lowerBound);
            newNest = min(newNest, upperBound);

            % Evaluate new solutions
            newFitness = fitnessFunction(newNest);

            % Update if the new solution is better
            if newFitness < fitness(i)
                nests(i, :) = newNest;
                fitness(i) = newFitness;

                % Update the global best
                if newFitness < bestFitness
                    bestFitness = newFitness;
                    bestNest = newNest;
                end
            end
        end

        % Abandon worse nests and build new ones
        for i = 1:numNests
            if rand() < pa
                nests(i, :) = lowerBound + (upperBound - lowerBound) * rand(1, dim);
                fitness(i) = fitnessFunction(nests(i, :));
            end
        end
    end
end

function step = levyFlights(dim)
    % Lévy flights
    beta = 3/2;
    sigma = (gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);
    u = randn(1, dim) * sigma;
    v = randn(1, dim);
    step = u ./ abs(v).^(1/beta);
end
