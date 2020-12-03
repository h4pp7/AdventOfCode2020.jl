module Day01
using AdventOfCode2020

function day01(input::AbstractString = readinput(
    joinpath(@__DIR__, "day01_input.txt")))

    data = split(input, "\n", keepempty=false)
    (Part1=part1(data), Part2=part2(data))
end

function part1(data::AbstractArray)
    nums = [parse(Int, n) for n in data]
    reduce(*, (x for x in nums, y in nums if x+y == 2020))
end

function part2(data::AbstractArray)
    nums = [parse(Int, n) for n in data]
    reduce(*, 
        [[x, y, z] for x in nums, 
        y in nums, 
        z in nums if x+y+z == 2020][1]
      )
end
end # module
