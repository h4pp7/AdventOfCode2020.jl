module Day03
using AdventOfCode2020

# TODO rewrite using OffsetArrays. Can I do something fun with OffsetArray
# indexed with CartesianIndex?

function parsemap(data)
    # Note to self: this yields an array with its colums as the rows of input,
    # which makes it intuitively indexable, e.g [3,1] = "three right, one
    # down". Think of it in this way and don't get confused by how it is
    # represented in the REPL.
    
    parserow(r) = [isequal('#', c) ? 1 : 0 for c in r] 
    return mapreduce(parserow, hcat, data) 
end

const input =   readinput(joinpath(@__DIR__, "Day03_input.txt")) |> 
                splitlines |> parsemap
const start_pos = CartesianIndex(1, 1)
const part1_slope = CartesianIndex(3, 1)
const part2_slopes = [CartesianIndex(1, 1), CartesianIndex(3, 1),
                      CartesianIndex(5, 1), CartesianIndex(7, 1),
                      CartesianIndex(1, 2)]

function solve(terrain = input, start = start_pos, slope = part1_slope, 
               slopes = part2_slopes)

    solution1 = count_trees(terrain, start, slope)
    solution2 = mapreduce(s -> count_trees(terrain, start, s), *, slopes)

    return (Part1=solution1, Part2=solution2)
end

function trajectory(start, slope, wrap, N)
    #TODO only works with indizes <= 2. How can I generalize that?
    path = accumulate(1:N; init=start) do x, _
        # mod1 prevents us from wrapping to 0
        CartesianIndex(mod1((x[1] + slope[1]), wrap), x[2]+slope[2])
    end
    return path
end

function count_trees(terrain, start, slope)
    wrap = size(terrain)[1]
    num_steps = ceil((size(terrain)[2] / slope[2]) - 1)
    path = trajectory(start, slope, wrap, num_steps)
    num_trees = sum((terrain[p] for p in path))
    return num_trees
end
end # module
