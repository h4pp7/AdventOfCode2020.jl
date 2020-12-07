module Day06
using AdventOfCode2020
using StatsBase

const raw_data = readinput(joinpath(@__DIR__, "Day06_input.txt"))

function solve(data = raw_data)
    groups = split(data, "\n\n")
    (Part1=part1(groups), Part2=part2(groups))
end

# This solution looks very minimal and clean:
# mapreduce(+, groups) do g
#   length(∪(split(g)...))
# end
#
# And for the second part to the same but with intersect
#   length(∩(split(g)...))
# But both use way more allocs and are slower than this:

function part1(groups = split(raw_data, "\n\n"))
    mapreduce(+, groups) do g
        # By just replacing the linebreak I don't need to split the groups in
        # lines first
        replace(g, "\n" => "") |> Set |> length
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
