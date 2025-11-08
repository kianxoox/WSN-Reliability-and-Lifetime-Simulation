function nextHops = selectNextHops_Custom(nodes, currentNodeId, sinkNodeId, params)
    neighbors = findNeighbors(nodes, currentNodeId, params.commRange);
    if isempty(neighbors)
        nextHops = [];
        return;
    end

    scores = [];
    for i = 1:length(neighbors)
        neighborId = neighbors(i);
        dist_current_to_sink = sqrt((nodes(currentNodeId).x - nodes(sinkNodeId).x)^2 + ...
                                    (nodes(currentNodeId).y - nodes(sinkNodeId).y)^2);
        dist_neighbor_to_sink = sqrt((nodes(neighborId).x - nodes(sinkNodeId).x)^2 + ...
                                     (nodes(neighborId).y - nodes(sinkNodeId).y)^2);

        if dist_neighbor_to_sink >= dist_current_to_sink
            continue;
        end

        distance_score = 1 - (dist_neighbor_to_sink / dist_current_to_sink);
        energy_score = nodes(neighborId).energy / params.initialEnergy;

        final_score = params.alpha_weight * distance_score + ...
                      (1 - params.alpha_weight) * energy_score;

        scores = [scores; neighborId, final_score];
    end

    if isempty(scores)
        nextHops = [];
        return;
    end

    sortedScores = sortrows(scores, 2, 'descend');
    if size(sortedScores, 1) >= 2
        nextHops = sortedScores(1:2, 1);
    else
        nextHops = sortedScores(1, 1);
    end
end
