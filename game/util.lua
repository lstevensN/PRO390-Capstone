DistanceBetween = function (x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

function math.clamp(low, n, high) return math.min(math.max(n, low), high) end