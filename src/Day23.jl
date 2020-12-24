module Day23
using AdventOfCode2020

const raw_input = [1,9,8,7,5,3,4,6,2]
const testinput = [3,8,9,1,2,5,4,6,7]

function solve(data = input)
    (Part1=part1(data), Part2=part2(data))
end

function finddest(c_val, cups)
    possible_dests = filter(x -> x < c_val, cups)
    if isempty(possible_dests)
        _, dest = findmax(cups)
    else
        dest = findfirst(x -> x == maximum(possible_dests), cups)
    end
    return dest
end

function step!(c_ind, cups)
    picks = splice!(cups, c_ind+1:c_ind+3)
    dest = finddest(cups[c_ind], cups)
    cups = vcat(cups[1:dest], picks, cups[dest+1:end])
    cups = circshift(cups, -1)
    return cups
end

function part1(steps = 100, input = raw_input)
    cups = copy(input)
    for i in 1:steps
        cups = step!(1, cups)
    end
    start = findfirst(x -> x == 1, cups)
    popat!(cups, start)
    return circshift(cups, -(start - 1)) |> join
end

function next_cup(c_ind, picks, cups)
    wrap(n) = mod1(n, length(cups))
    next_cup = wrap(c_ind - 1)
    while next_cup in picks
        next_cup = wrap(next_cup - 1)
    end
    return next_cup
end

function step_2!(c_ind, cups)
	# update so, that 
    # - current cup points to what 3 ahead pointed to
    # - next cup points to what current cup pointed to
    # - 3 ahead points to what next cup pointed to

    picks = (cups[c_ind], cups[cups[c_ind]], cups[cups[cups[c_ind]]])
    dest = next_cup(c_ind, picks, cups)
    next_ind = cups[picks[3]]
    cups[picks[3]] = cups[dest]
    cups[dest] = cups[c_ind]
    cups[c_ind] = next_ind
    return cups
end

function part2(steps = 10^7, input = raw_input)
    
    cups = Vector{Int32}(undef, length(input))
    for i in 1:length(input) - 1
        cups[input[i]] = input[i+1]
    end
    cups[input[end]] = maximum(input) + 1
    m = maximum(cups) 
	append!(cups, m+1:10^6)
	append!(cups, input[1])
    c_ind = Int32(input[1])
    for i in 1:steps
        cups = step_2!(c_ind, cups)
        c_ind = cups[c_ind]
    end
    return Int64(cups[1]) * cups[cups[1]]
end
end # module
