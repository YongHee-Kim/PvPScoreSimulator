immutable League
    min::Int16
    max::Int16
    names::Vector{String}
    upper_bounds::Dict{Int16, Function}
    lower_bounds::Dict{Int16, Function}
    scoring::Any
end
