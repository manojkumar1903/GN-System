% Load Data from CSV
filePath = 'C:/Users/Admin/Desktop/data.csv';
data = readtable(filePath);

% Assuming the first 'dim' columns are load profile data
loadProfile = mean(table2array(data(:, 1:dim)), 2);

% Assuming the next 'dim' columns are EV profile data
evProfile = table2array(data(:, dim+1:2*dim));

% Assuming the next 'dim' columns are ToU pricing data
touPricing = table2array(data(:, 2*dim+1:3*dim));

% Other parameters
% Update these indices based on your CSV structure
peakHours = table2array(data(:, 3*dim+1));
peakLoadPenaltyFactor = table2array(data(:, 3*dim+2));
someThreshold = table2array(data(:, 3*dim+3));

% Define the number of bats, vultures, etc., and other parameters
numBats = 10;
numVultures = 10;

% Running the optimization algorithms
batConvergence = batAlgorithm(loadProfile, evProfile, touPricing, peakHours, peakLoadPenaltyFactor, numBats, dim, 10);


% Data export to Excel (using table and writetable)
data = table(batConvergence, ...); % Add other convergence data
excelPath = 'C:/Users/Admin/Downloads/optimization_convergence.xlsx';
writetable(data, excelPath);

disp(['Data exported to ', excelPath]);

% Plotting the convergence of all algorithms
figure;
plot(batConvergence, 'DisplayName', 'Bat Optimization');

xlabel('Iteration');
ylabel('Fitness Value');
title('Convergence Comparison');
legend;
grid on;