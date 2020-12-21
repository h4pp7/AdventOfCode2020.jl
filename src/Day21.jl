module Day21
using AdventOfCode2020

function solve()
    input = eachline(joinpath(@__DIR__, "Day21_input.txt"))
    possible_matches, ingredient_list = parse_foods(input)
    solution1 = part1(possible_matches, ingredient_list)
    solution2 = part2(possible_matches)
    return (Part1 = solution1, Part2 = solution2)
end

function part1(possible_matches, ingredient_list)
    return count(x -> all(x .∉ values(possible_matches)), ingredient_list)
end

function part2(possible_matches)
    # just copied this from day 16
    matched = Dict()
    while !isempty(possible_matches)
        for (i, labels) in possible_matches
            if length(labels) == 1
                label = labels[1]
                matched[i] = label
                pop!(possible_matches, i)
                for l in values(possible_matches)
                    setdiff!(l, [label])
                end
                break
            end
        end
    end
    return join((matched[k] for k in sort(collect(keys(matched)))), ",")
end

function parse_foods(input)
    contains = Dict()
    ingredient_list = []
    for l in input
        ingr, allergens = split(l, " (")
        ingredients = split(ingr)
        push!(ingredient_list, ingredients...)
        for a in eachmatch(r"\w+", allergens)
            if a.match != "contains"
                contains[a.match] = push!(get(contains, a.match, Array{SubString{String}}[]), ingredients)
            end
        end
    end
    mappings = Dict{String}{Array{SubString{String}}}()
    for (a, i) in contains
        mappings[a] = ∩(contains[a]...)
    end
    return mappings, ingredient_list
end
end # module
