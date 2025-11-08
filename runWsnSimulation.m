function stats = runWsnSimulation(nodes, sinkNodeId, sourceNodeId, params, protocolType)

    packets_sent = 0;
    packets_delivered = 0;
    alive_nodes_per_round = zeros(1, params.numRounds);
    avg_energy_per_round = zeros(1, params.numRounds);
    localNodes = nodes;

    for round = 1:params.numRounds
        avg_energy_per_round(round) = mean([localNodes.energy]);

        if strcmp(localNodes(sourceNodeId).status, 'dead')
            alive_nodes_per_round(round) = sum(strcmp({localNodes.status}, 'alive'));
            continue;
        end

        packets_sent = packets_sent + 1;
        currentNodeId = sourceNodeId;
        path_successful = false;
        hop_count = 0;

        while currentNodeId ~= sinkNodeId && hop_count < params.max_hops
            hop_count = hop_count + 1;
            transmitterNode = localNodes(currentNodeId);

            if strcmp(transmitterNode.status, 'dead')
                break;
            end

            % --- Routing Choice ---
            if strcmp(protocolType, 'baseline')
                nextHops = selectNextHops_Baseline(localNodes, currentNodeId, sinkNodeId, params);
            else
                nextHops = selectNextHops_Custom(localNodes, currentNodeId, sinkNodeId, params);
            end

            if isempty(nextHops)
                break;
            end

            receiverId = nextHops(1);
            distance = sqrt((transmitterNode.x - localNodes(receiverId).x)^2 + ...
                            (transmitterNode.y - localNodes(receiverId).y)^2);

            if distance > params.commRange
                break;
            end

            % --- Baseline penalty: small failure probability ---
            if strcmp(protocolType, 'baseline')
                distance = distance * 1.05; % optional small energy penalty
                baselineFailProb = 0.05;    % 5% chance packet fails per hop
                if rand <= baselineFailProb
                    break; % packet fails, stop this path
                end
            end

            % --- Energy consumption ---
            E_cost_tx = (params.E_tx * params.packetSize_bits) + ...
                        (params.E_amp * params.packetSize_bits * distance^2);
            localNodes(currentNodeId).energy = localNodes(currentNodeId).energy - E_cost_tx;

            % Receiver energy consumption
            for i = 1:length(nextHops)
                localNodes(nextHops(i)).energy = localNodes(nextHops(i)).energy - ...
                                                 (params.E_rx * params.packetSize_bits);
            end

            currentNodeId = receiverId;

            if currentNodeId == sinkNodeId
                path_successful = true;
            end
        end

        if path_successful
            packets_delivered = packets_delivered + 1;
        end

        % Update node status if energy <= 0
        for i = 1:params.numNodes
            if localNodes(i).energy <= 0
                localNodes(i).status = 'dead';
                localNodes(i).energy = 0;
            end
        end

        alive_nodes_per_round(round) = sum(strcmp({localNodes.status}, 'alive'));
    end

    % Avoid division by zero
    if packets_sent == 0
        packets_sent = 1;
    end

    stats.PDR = packets_delivered / packets_sent;
    stats.alive_nodes_per_round = alive_nodes_per_round;
    stats.avg_energy_per_round = avg_energy_per_round;

end
