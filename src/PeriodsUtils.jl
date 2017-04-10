module PeriodsUtils

export ismember

function ismember(i::Int, v::Vector{Int})
    return any(i.==v)
end

end
