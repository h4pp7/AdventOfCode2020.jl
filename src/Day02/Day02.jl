module Day02
using AdventOfCode2020

function solve(input::AbstractString = readinput(
    joinpath(@__DIR__, "Day02_input.txt")))
    data = split(input, "\n", keepempty=false)
    return (Part1=part1(data), Part2=part2(data))
end

function parse_pw(line::AbstractString)
    rule, pw = split(line, ": ")
    char = last(rule)
    min, max = rule[1:end-2] |> x -> split(x, "-") |> x -> parse.(Int, x)
    return pw, char, min, max
end

function part1(data)
    valids = filter(data) do line
        pw, char, min, max = parse_pw(line)
        min <= count(isequal(char), pw) <= max
    end
    return length(valids)
end

function part2(data)
    valids = filter(data) do line
        pw, char, first, second = parse_pw(line)
        xor(isequal(char, pw[first]), isequal(char, pw[second]))
    end
    return length(valids)
end
end # module
