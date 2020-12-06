module Day06
using AdventOfCode2020
using StatsBase
# TODO rewrite with loops. How can I get the memory ?

const raw_data = readinput(joinpath(@__DIR__, "Day06_input.txt"))

function solve(data = raw_data)
    groups = split(data, "\n\n")
    (Part1=part1(groups), Part2=part2(groups))
end

function part1(groups = split(raw_data, "\n\n"))
    mapreduce(+, groups) do l
        replace(l, "\n" => "") |> Set |> length
    end
end

function part2(groups = split(raw_data, "\n\n", keepempty = false))
    mapreduce(+, groups) do g
        counts = countmap((c for c in g))   
        if haskey(counts, '\n')
            s = 0
            for (k,v) in counts
                if v > counts['\n']
                    s += 1
                end
            end
        else
            s = counts.count
        end
    s
    end
end
end # module
