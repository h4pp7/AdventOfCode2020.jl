module Day05
using AdventOfCode2020

const raw_data = readinput(joinpath(@__DIR__, "Day04_input.txt"))

function solve(input = raw_data)
    data = split(input, "\n", keepempty=false)
    (Part1=part1(data), Part2=part2(data))
end

function part1(data)
    missing
end

function part2(data)
    missing
end
end # module
