module Day02
using AdventOfCode2020

# TODO parse rules and passwords with regex
const input = readinput(joinpath(@__DIR__, "Day02_input.txt")) |>
              splitlines

function parse_pw(line)
    rule, pw = split(line, ": ")
    char = last(rule)
    min, max = rule[1:end-2] |> x -> split(x, "-") |> x -> parse.(Int, x)
    return [pw, char, min, max]
end

# Doesn't make a difference to declare it as const here, the compiler figures
# it out
const rule_pw_sets = map(input) do l
    parse_pw(l)
end

function solve(data = rule_pw_sets)
    return (Part1=part1(rule_pw_sets), Part2=part2(rule_pw_sets))
end

function solveboth(data = rule_pw_sets)
    # filter to times with a closure needs exactly half as many allocs as this
    # for loop
    valids1 = []
    valids2 = []
    for l in data
        pw, char, min, max = l
        push!(valids1, min <= count(isequal(char), pw) <= max)
        push!(valids2, xor(isequal(char, pw[min]), isequal(char, pw[max])))
    end
    return (Part1=part1(rule_pw_sets), Part2=part2(rule_pw_sets))
end

function part1(rule_pw_sets)
    valids = filter(rule_pw_sets) do line
        pw, char, min, max = line
        min <= count(isequal(char), pw) <= max
    end
    return length(valids)
end

function part2(rule_pw_sets)
    valids = filter(rule_pw_sets) do line
        pw, char, first, second = line
        xor(isequal(char, pw[first]), isequal(char, pw[second]))
    end
    return length(valids)
end
end # module
