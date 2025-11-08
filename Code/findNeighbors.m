function neighbors = findNeighbors(nodes, currentNodeId, commRange)
    neighbors = [];
    for i = 1:length(nodes)
        if i ~= currentNodeId && strcmp(nodes(i).status, 'alive')
            distance = sqrt((nodes(currentNodeId).x - nodes(i).x)^2 + ...
                            (nodes(currentNodeId).y - nodes(i).y)^2);
            if distance <= commRange
                neighbors = [neighbors, i];
            end
        end
    end
end
