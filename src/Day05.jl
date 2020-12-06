module Day05
using AdventOfCode2020

const raw_data = readinput(joinpath(@__DIR__, "Day05_input.txt"))

const mappings = Dict('F' => '0', 'B' => '1', 'L' => '0', 'R' => '1', '\n' => ' ') 

function solve(input = raw_data)
    (Part1=part1(input), Part2=part2(data))
end

function part1(input = raw_data)
    solution1 = maximum(parse.(Int, split(join((mappings[c] for c in input))), base = 2))
end

function part2(data)
    missing
end
end # module
