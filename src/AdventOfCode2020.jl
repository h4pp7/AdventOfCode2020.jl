module AdventOfCode2020

using StrLiterals
using StrFormat

for i in 1:26
    include(joinpath(@__DIR__, f"Day\%02d(i).jl"))
end

export  Day01, Day02, Day03, Day04, Day05, Day06, Day07, Day08, Day09, 
        Day10, Day11, Day12, Day13, Day14, Day15, Day16, Day17, Day18, 
        Day19, Day20, Day21, Day22, Day23, Day24, Day25, Day26, 
        readinput, splitlines

function readinput(path::AbstractString)
    open(path, "r") do f
        read(f, String)
    end
end

function splitlines(input::AbstractString)
    split(input, "\n", keepempty=false)
end

function setup_project()
    for i = 1:26
        input_name = joinpath(@__DIR__, f"Day\%02d(i)_input.txt")
        solution_name = joinpath(@__DIR__, f"Day\%02d(i).jl")

        if ispath(input_name) == false
            touch(input_name)
        end
        if ispath(solution_name) == false
			touch(solution_name)
            open(solution_name, "w") do io
                write(io, f"""module Day\%02d(i)
using AdventOfCode2020

function solve(input::AbstractString = readinput(
    joinpath(@__DIR__, "Day\%02d(i)_input.txt")))
    data = split(input, "\n", keepempty=false)
    (Part1=part1(data), Part2=part2(data))
end

function part1(data::AbstractArray)
    missing
end

function part2(data::AbstractArray)
    missing
end
end # module""")
            end
        end
    end
end

end # module
