module Day22
using AdventOfCode2020

const raw_input = readinput(joinpath(@__DIR__, "Day22_input.txt"))

function make_decks(input)
    p1, p2 = (split.(split(input, "\n\n"))[i][3:end] for i in 1:2)
    return parse.(Int, p1), parse.(Int, p2)
end

function solve(input = raw_input)
    (Part1=part1(input), Part2=part2(input))
end

function part1(input = raw_input)
    p1, p2 = make_decks(input)
    winner = combat(p1, p2)
    return winner'collect(length(winner):-1:1) 
end

function combat(p1, p2)
    while !any(isempty, (p1, p2))
        a, b = popfirst!(p1), popfirst!(p2)
        a > b ? append!(p1, [a, b]) : append!(p2, [b, a])
    end
    isempty(p1) ? winner = p2 : winner = p1
    return winner
end

function recursive_combat(p1, p2)

    d1 = copy(p1)
    d2 = copy(p2)
    turns = []

    while !any(isempty, (d1, d2))
        if [d1, d2] in turns
            return 1, d1
        end
        push!(turns, [copy(d1), copy(d2)])
        a, b = popfirst!(d1), popfirst!(d2)
        if length(d1) ≥ a && length(d2) ≥ b
            player, _ = recursive_combat(d1[1:a], d2[1:b])
            if player == 1
                append!(d1, [a, b])
            else
                append!(d2, [b, a])
            end

        elseif a > b
            append!(d1, [a, b])
        else
            append!(d2, [b, a])
        end
    end
    if isempty(d1)
        return 2, d2
    else
        return 1, d1
    end
end

function part2(input = raw_input)
    p1, p2 = make_decks(input)
    _, winner = recursive_combat(p1, p2)
    return winner'collect(length(winner):-1:1)
end
end # module
