module Day02

using Main.AdventOfCode2020
#include("../AdventOfCode2020.jl")

function day02(input::AbstractString = readinput(
                "day02/day02_input.txt"
               ))
    data = split(input, "\n", keepempty=false)
    (part1=part1(data), part2=part2(data))
end

function part1(data)
    function validate(pair)
        # get rule - password pair
        rule, pw = split(pair, ": ")
        # get range and target char
        char = last(rule)
        min, max = rule[1:end-2] |> x -> split(x, "-") |> x -> parse.(Int, x)
        min <= count(isequal(char), pw) <= max
    end

    length(filter(validate, data))
end

function part2(data)
    missing
end

end # module
