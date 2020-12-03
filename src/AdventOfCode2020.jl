module AdventOfCode2020

using StrLiterals
using StrFormat

for i in 1:2
    include(joinpath(@__DIR__, f"Day\%02d(i)", f"Day\%02d(i).jl"))
end

export readinput, Day01, Day02, Day03

function readinput(path::AbstractString)
    open(path, "r") do f
        read(f, String)
    end
end

function setup_project()
    for i = 1:26
        dir_name = joinpath(@__DIR__, f"Day\%02d(i)")
        input_name = joinpath(@__DIR__, f"Day\%02d(i)/Day\%02d(i)_input.txt")
        solution_name = joinpath(@__DIR__, f"Day\%02d(i)/Day\%02d(i).jl")

        if ispath(dir_name) == false
            mkdir(dir_name)
        end
        if ispath(input_name) == false
            touch(input_name)
        end
        if ispath(solution_name) == false
			touch(solution_name)
            open(solution_name, "w") do io
                write(io, f"""module Day\%02d(i)
using AdventOfCode2020

function solve(i)(input::AbstractString = readinput(
    joinpath(@__DIR__, "day\%02d(i)_input.txt")))
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
