module Day09
using AdventOfCode2020
using Combinatorics

const raw_data = readinput(joinpath(@__DIR__, "Day09_input.txt"))

function solve(data = raw_data)
    N = [parse(Int, n.match) for n in eachmatch(r"\d+", data)]
    solution1, hit_ind = part1(N, 25)
    solution2 = part2(N, hit_ind)
    (Part1=solution1, Part2=solution2)
end

function part1(N, w)
    # TODO replace combinations with something that just operates on views --
    # would that reduce the allocs? Part 2 makes 1 alloc with 16 byte :shrug:
    # But maybe combinations is not the culprit...
    @views for i in 1:length(N) - w
        s = any(sum(c) == N[i+w] for c in combinations(N[i:i+w-1], 2))
        if s == false
            return N[i+w], i+w
        end
    end
end

function part2(N, hit_ind)
    i = 1 
    j = 1

    @views while sum(N[hit_ind-j:hit_ind-i]) != N[hit_ind]
        s = sum(N[hit_ind-j:hit_ind-i])
        if s == N[hit_ind]
            break
        elseif s > N[hit_ind]
            i += 1
        else
        j += 1
        end
    end
    max = maximum(@view N[hit_ind-j:hit_ind-i])
    min = minimum(@view N[hit_ind-j:hit_ind-i])
    return max + min
end

end # module
