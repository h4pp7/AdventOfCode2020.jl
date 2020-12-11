module Day10
using AdventOfCode2020

const raw_data = readinput(joinpath(@__DIR__, "Day10_input.txt"))

function part1(N)
    sort!(N)
    ones = count(x -> N[x+1] - N[x] == 1, (1:length(N)-1))
    threes = count(x -> N[x+1] - N[x] == 3, (1:length(N)-1)) + 1
    first(N) == 1 ? ones += 1 : threes += 1 # assuming there is no 2
    ones * threes
end

function count_ones_seqs(D)
    one_seqs = Dict{Int, Int}() 
    c = 0

    push_or_store(x) = 
        haskey(one_seqs, x) ? one_seqs[x] += 1 : push!(one_seqs, x => 1)

    for n in D
        if n == 1 
            c += 1
        else
            push_or_store(c)
            c = 0
        end
    end
    push_or_store(c)
    one_seqs
end

function part2(N)
    D = vcat([0], N, [maximum(N) + 3]) |> sort |> diff
    one_seqs = count_ones_seqs(D)
    # The other alternative is to use run length encoding to get the sequences
    2 ^ one_seqs[2] * 4 ^ one_seqs[3] * 7 ^ one_seqs[4]
end

function solve(data = raw_data)
    N = parse.(Int, split(data))
    solution1 = part1(N)
    solution2 = part2(N)
    (Part1=solution1, Part2=solution2)
end
end # module
