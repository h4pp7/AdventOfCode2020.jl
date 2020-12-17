module Day15
using AdventOfCode2020

const raw_input = "2,15,0,9,1,20"

function solve(input = raw_input)
    (Part1=play(input, 2020), Part2=play(input, 30000000))
end

function play(input, N)
    list = parse.(Int, split(input, ","))
    d = Dict(list[i] => i for i in 1:length(list) - 1)
    last_n = last(list)

    for i in length(d)+2:N
        if last_n in keys(d) 
            current = i - 1 - d[last_n]
        else
            current = 0
        end
        d[last_n] = i - 1
        last_n = current
    end
    return last_n
end

function play_vec(input, N)
    # use vec instead of dict. Same idea: indizes for the humbers, values for
    # time
    list = parse.(Int, split(input, ","))
    cache = zeros(Int, maximum(list)+1)
    for (i, n) in enumerate(list)
        cache[n+1] = i 
    end
    last_n = pop!(cache)
    last_n = last(list)
    for i in maximum(cache)+1:N
        i_, n = findmax(cache)
        @info "i, i_, n" i, i_, n
        if cache[last_n] == 0
            cache[0+1] = i
        else
            if n + 1 > length(cache)
                append!(cache, zeros(n - length(cache) +1))
            end
            cache[n+1] = last_n
        end
        last_n = i - 1 - cache[n]
        @info "cache" cache
    end
    i_, n = findmax(cache)
    return cache, n - 1
end
end # module
