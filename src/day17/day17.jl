module Day17
using AdventOfCode2020

function day17(input::AbstractString = readinput(
    joinpath(@__DIR__, "day17_input.txt")))

    data = split(input, "
", keepempty=false)
    (Part1=part1(data), Part2=part2(data))
end

function part1(data::AbstractArray)
    missing
end

function part2(data::AbstractArray)
    missing
end
end # module