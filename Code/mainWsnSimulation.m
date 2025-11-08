% =========================================================================
% MAIN SCRIPT: WSN Reliability and Lifetime Simulation (Enhanced)
% =========================================================================
clear;
clc;
close all;

%% CONFIGURATION PARAMETERS
fprintf('Setting up network parameters...\n');

params.networkArea = [100, 100];
params.numNodes = 50;
params.initialEnergy = 0.2; % Reduced to make nodes die faster
params.commRange = 25; % Reduced range for realistic packet loss

sinkNodeId = 1;
sourceNodeId = params.numNodes;

params.E_tx = 50e-9;
params.E_rx = 50e-9;
params.E_amp = 100e-12;
params.packetSize_bits = 4000;

params.numRounds = 2000;
params.alpha_weight = 0.8; % Prioritize distance (80%) over energy (20%)
params.max_hops = 15;

%% NETWORK INITIALIZATION
fprintf('Initializing sensor node deployment...\n');
nodes = struct('id', {}, 'x', {}, 'y', {}, 'energy', {}, 'status', {});
for i = 1:params.numNodes
    nodes(i).id = i;
    nodes(i).x = rand() * params.networkArea(1);
    nodes(i).y = rand() * params.networkArea(2);
    nodes(i).energy = params.initialEnergy;
    nodes(i).status = 'alive';
end

% Define fixed sink and source positions
nodes(sinkNodeId).x = params.networkArea(1) / 2;
nodes(sinkNodeId).y = params.networkArea(2) / 2;
nodes(sourceNodeId).x = params.networkArea(1) * 0.95;
nodes(sourceNodeId).y = params.networkArea(2) * 0.95;

figure;
hold on;
plot(nodes(sinkNodeId).x, nodes(sinkNodeId).y, 'kp', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
plot(nodes(sourceNodeId).x, nodes(sourceNodeId).y, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
for i = 1:params.numNodes
    if i ~= sinkNodeId && i ~= sourceNodeId
        plot(nodes(i).x, nodes(i).y, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'b');
    end
end
title('Initial Network Deployment');
legend('Sink Node', 'Source Node', 'Sensor Nodes');
grid on;

%% RUN SIMULATIONS
fprintf('\n--- Running BASELINE Protocol Simulation ---\n');
stats_baseline = runWsnSimulation(nodes, sinkNodeId, sourceNodeId, params, 'baseline');
fprintf('\nBaseline Simulation Complete. Final PDR: %.2f%%\n', stats_baseline.PDR * 100);

fprintf('\n--- Running CUSTOM Energy-Aware Multipath Protocol ---\n');
stats_custom = runWsnSimulation(nodes, sinkNodeId, sourceNodeId, params, 'custom');
fprintf('\nCustom Protocol Simulation Complete. Final PDR: %.2f%%\n', stats_custom.PDR * 100);

%% RESULTS VISUALIZATION
fprintf('\nGenerating enhanced comparison plots...\n');
fig = figure('Name', 'WSN Simulation Results', 'Position', [100, 100, 1400, 500]);
sgtitle('Protocol Performance Comparison (Enhanced)', 'FontSize', 16, 'FontWeight', 'bold');

% Plot 1: Network Lifetime
subplot(1, 3, 1);
plot(1:params.numRounds, stats_baseline.alive_nodes_per_round, 'r-', 'LineWidth', 2);
hold on;
plot(1:params.numRounds, stats_custom.alive_nodes_per_round, 'b-', 'LineWidth', 2);
title('Network Lifetime Comparison');
xlabel('Simulation Round');
ylabel('Number of Alive Nodes');
legend('Baseline', 'Custom');
grid on;
ylim([0, params.numNodes]);

% Plot 2: Reliability (PDR)
subplot(1, 3, 2);
pdr_results = [stats_baseline.PDR, stats_custom.PDR] * 100;
bar_handle = bar(pdr_results, 'FaceColor', 'flat');
bar_handle.CData(1,:) = [1 0 0]; % Red
bar_handle.CData(2,:) = [0 0 1]; % Blue
set(gca, 'xticklabel', {'Baseline', 'Custom'});
ylabel('Packet Delivery Ratio (PDR) %');
title('Protocol Reliability Comparison');
ylim([0 100]);
grid on;

% Plot 3: Average Residual Energy
subplot(1, 3, 3);
plot(1:params.numRounds, stats_baseline.avg_energy_per_round, 'r-', 'LineWidth', 2);
hold on;
plot(1:params.numRounds, stats_custom.avg_energy_per_round, 'b-', 'LineWidth', 2);
title('Average Residual Energy');
xlabel('Simulation Round');
ylabel('Energy (Joules)');
legend('Baseline', 'Custom');
grid on;

fprintf('\n✅ Simulation and plotting complete.\n');
