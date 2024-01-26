function [bestSolution, bestFitness] = batAlgorithm(fitnessFunction, numBats, dim, iterMax, freqMin, freqMax, alpha, gamma)
    % Initialize parameters
    A = ones(numBats, 1);  % Loudness
    r = zeros(numBats, 1); % Pulse rate
    Qmin = freqMin;        % Frequency minimum
    Qmax = freqMax;        % Frequency maximum

    % Initialize the bat population
    positions = rand(numBats, dim); % Random positions
    velocities = zeros(numBats, dim); % Initial velocities
    frequencies = zeros(numBats, 1); % Initial frequencies

    % Evaluate initial population
    fitness = arrayfun(@(i) fitnessFunction(positions(i,:)), 1:numBats);
    [bestFitness, bestIdx] = min(fitness);
    bestSolution = positions(bestIdx, :);

    % Bat Algorithm main loop
    for t = 1:iterMax
        for i = 1:numBats
            % Update frequency
            frequencies(i) = Qmin + (Qmax - Qmin) * rand();

            % Update velocity and position
            velocities(i, :) = velocities(i, :) + (positions(i, :) - bestSolution) * frequencies(i);
            newSolution = positions(i, :) + velocities(i, :);

            % Local search
            if rand() > r(i)
                newSolution = bestSolution + 0.001 * randn(1, dim);
            end

            % Evaluate new solutions
            newFitness = fitnessFunction(newSolution);

            % Update if the new solution is better
            if (newFitness <= fitness(i)) && (rand() < A(i))
                positions(i, :) = newSolution;
                fitness(i) = newFitness;
                A(i) = alpha * A(i);
                r(i) = r(i) * (1 - exp(-gamma * t));
            end

            % Update the global best
            if newFitness <= bestFitness
                bestSolution = newSolution;
                bestFitness = newFitness;
            end
        end
    end
end
