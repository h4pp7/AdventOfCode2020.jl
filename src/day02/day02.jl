module Day02
using AdventOfCode2020

function day02(input::AbstractString = readinput(
    joinpath(@__DIR__, "day02_input.txt")))

    data = split(input, "\n", keepempty=false)
    (Part1=part1(data), Part2=part2(data))
end

function part1(data)
    function validate(pair)
        rule, pw = split(pair, ": ")
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
