module Day03
using AdventOfCode2020
using OffsetArrays

# TODO rewrite using OffsetArrays. Can I do something fun with OffsetArray
# indexed with CartesianIndex?

function parsemap(data)
    # Note to self: this yields an array with its colums as the rows of input,
    # which makes it intuitively indexable, e.g [3,1] = "three right, one
    # down". Think of it in this way and don't get confused by how it is
    # represented in the REPL.
    
    #parserow(r) = [isequal('#', c) ? 1 : 0 for c in r] 
    # Changing this function this is the big memory alloc save
    terrain = mapreduce(r -> collect(r).∈"#", hcat, data) 
    @views OffsetArray(terrain, 0:size(terrain)[1] - 1, 0:size(terrain)[2] - 1)
end

const raw_data = readinput(joinpath(@__DIR__, "Day03_input.txt"))
const start_pos = (0, 0)
const part1_slope = (3, 1)
const part2_slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]

function solve(input = raw_data, start = start_pos, slope = part1_slope, 
               slopes = part2_slopes)

    terrain = splitlines(input) |> parsemap
    solution1 = count_trees(terrain, start, slope)
    solution2 = @views mapreduce(s -> count_trees(terrain, start, s), *, slopes)

    (Part1=solution1, Part2=solution2)
end

function count_trees(terrain, start, slope)
    wrap = size(terrain)[1] 
    num_steps = (size(terrain)[2] - 1) / slope[2] + 1

    trees = 0
    x, y = start
    for i = 1:num_steps
        trees += terrain[x, y]
        x = mod(x + slope[1], wrap)
        y += slope[2]
    end
    trees

    #= this takes double the time and memory than the loop, sadly
    x, y = start
    trees = accumulate(1:num_steps; init = 0) do t, _
        t += terrain[x, y]
        x = mod(x + slope[1], wrap)
        y += slope[2]
        t
    end
    last(trees)
    =#
end
end # module
