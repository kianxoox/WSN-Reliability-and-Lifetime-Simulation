function nextHops = selectNextHops_Baseline(nodes, currentNodeId, sinkNodeId, params)
    neighbors = findNeighbors(nodes, currentNodeId, params.commRange);
    if isempty(neighbors)
        nextHops = [];
        return;
    end

    E_min = inf;
    bestNeighbor = -1;

    for i = 1:length(neighbors)
        neighborId = neighbors(i);
        if strcmp(nodes(neighborId).status, 'dead')
            continue;
        end

        % Distance between current and neighbor
        d = sqrt((nodes(currentNodeId).x - nodes(neighborId).x)^2 + ...
                 (nodes(currentNodeId).y - nodes(neighborId).y)^2);

        % Energy cost for transmission from current -> neighbor
        E_tx_cost = (params.E_tx * params.packetSize_bits) + ...
                    (params.E_amp * params.packetSize_bits * d^2);

        % Heuristic: add energy cost from neighbor to sink (estimate)
        d_to_sink = sqrt((nodes(neighborId).x - nodes(sinkNodeId).x)^2 + ...
                         (nodes(neighborId).y - nodes(sinkNodeId).y)^2);
        E_sink_est = (params.E_tx * params.packetSize_bits) + ...
                     (params.E_amp * params.packetSize_bits * d_to_sink^2);

        totalCost = E_tx_cost + E_sink_est;

        if totalCost < E_min
            E_min = totalCost;
            bestNeighbor = neighborId;
        end
    end

    if bestNeighbor == -1
        nextHops = [];
    else
        nextHops = bestNeighbor;
    end
end
