module Day07
using AdventOfCode2020

const raw_data = readinput(joinpath(@__DIR__, "Day07_input.txt"))
const wanted_bag = "shiny gold"

#=
TODO reimplement with a matrix. Dict with colors from first Position as key
and linenumber as value. Make a Matrix the length of that Dict. Walk through
the lines again and put the numbers of contained bags in the corresponding
coloumn.

            light orange    dark orange bright white    muted yellow
light red                               1               2 
dark orange                             3               4
bright white
muted yellow

etc
=#

function parse_rules(data = raw_data)

    lines = splitlines(data)
    container_p = r"^\w*\s\w*(?=\sbag)"
    contained_p = r"(?<=\s)\w*\s\w*(?=\sbag)"

    rules = Dict()

    for l in lines
        container = match(container_p, l) 
        contained = eachmatch(contained_p, l)
        for match in contained
            if haskey(rules, match.match)
                append!(rules[match.match], [container.match])
            else
                push!(rules, match.match => [container.match])
            end
        end
    end
    rules
end

function findbagcontents(bag, lines)

    contained_p = r"(\d)\s(\D*\s\D*(?=\sbag))"
    bag_p = r"^" * bag
    colors = []
    num = 0

    for (i, l) in enumerate(lines)
        if occursin(bag_p, l)
            for match in eachmatch(contained_p, l)
                push!(colors, match.captures[2])
                num += parse(Int, match.captures[1])
            end
            if num == 0
                return nothing
            end
            deleteat!(lines, i)
            return num, colors
        end
    end
    nothing
end

function walk_down(searched_bags, num, lines)

    # I can't just add the numbers from findbagcontents. I need to go down the
    # path for one match first, multiply all of them, then the next match and
    # add both together.
    next_pair = findbagcontents(searched_bags, lines)
    if  next_pair == nothing
        return searched_bags, num
    end

    num += next_pair[1] 
    searched_bags = next_pair[2]

    for b in searched_bags
        searched_bags, num = walk_down(b, num, lines)
    end
    searched_bags, num
end

function solve(data = raw_data)
    bag = wanted_bag
    solution1 = part1(bag, data)
    solution2 = part2(bag, data)
    (Part1=solution1, Part2=solution2)
end

function part1(bag, data = raw_data)
    rules = parse_rules(data)
    memory = []
    walk_up(bag, rules, memory) |> length
end

function part2(bag, data = raw_data)
    lines = splitlines(data)
    walk_down(bag, 0, lines)[2]
end

function walk_up(bag, rules, memory)

    if !(haskey(rules, bag)) return memory end

    next_col = []
    for c in rules[bag]
        if !(c in memory)
            push!(memory, c)
            next_col = walk_up(c, rules, memory)
        end
    end
    next_col
end
end # module
