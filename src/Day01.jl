module Day01
using AdventOfCode2020

const raw_data = readinput(joinpath(@__DIR__, "Day01_input.txt"))

function solve(input = raw_data)
    data = split(input, "\n", keepempty=false)
    return (Part1=part1(data), Part2=part2(data))
end

function part1(data)
    nums = [parse(Int, n) for n in data]
    return reduce(*, (x for x in nums, y in nums if x+y == 2020))
end

function part2(data)
    nums = [parse(Int, n) for n in data]
    prod = reduce(*, 
        [[x, y, z] for x in nums, 
        y in nums, 
        z in nums if x+y+z == 2020][1]
      )
    return prod
end
end # module
