module Day03
using AdventOfCode2020

# TODO rewrite using OffsetArrays. Can I do something fun with OffsetArray
# indexed with CartesianIndex?

function solve(input::AbstractString = readinput(
    joinpath(@__DIR__, "Day03_input.txt")))
    data = splitlines(input)
    (Part1=part1(data), Part2=part2(data))
end

function parsemap(data)
    # this yields an array with its colums as the rows of input, which makes it
    # intuitively indexable, e.g [3,1] = "three right, one down"
    parserow(r) = [isequal('#', c) ? 1 : 0 for c in r]
    return map = mapreduce(parserow, hcat, data)
end

function trajectory(start, slope, wrap, n)
    #TODO only works with indizes <= 2. How can I generalize that?
    path = accumulate(1:n; init=start) do x, _
        # mod1 prevents us from wrapping to 0
        CartesianIndex(mod1((x[1] + slope[1]), wrap), x[2]+slope[2])
    end
    return path
end

function count_trees(data::AbstractArray, start, slope)
    map = parsemap(data)
    wrap = size(map)[1]
    num_steps = ceil((size(map)[2] / slope[2]) - 1)
    path = trajectory(start, slope, wrap, num_steps)
    num_trees = sum([map[p] for p in path])
    return num_trees
end

function part1(data::AbstractArray,
           start::CartesianIndex = CartesianIndex(1, 1), 
           slope::CartesianIndex = CartesianIndex(3, 1))
    count_trees(data, start, slope)
end

function part2(data::AbstractArray,
           start::CartesianIndex = CartesianIndex(1, 1), 
           slopes = [
                    CartesianIndex(1, 1),
                    CartesianIndex(3, 1),
                    CartesianIndex(5, 1),
                    CartesianIndex(7, 1),
                    CartesianIndex(1, 2)])
    # TODO wrap this, so that don't have to pass everything 
    reduce(*, [count_trees(data, start, slope) for slope in slopes])
end
end # module
