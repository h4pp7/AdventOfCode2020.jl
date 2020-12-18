module Day18
using AdventOfCode2020

const raw_input = readinput(joinpath(@__DIR__, "Day18_input.txt"))

function rpn(line::AbstractString, rank = Dict(('*' => 1),('+' => 0)))

    token = replace(line, " " => "") |> collect
    nums = "0123456789"
    ops = "+*"
    op = [] 
    out = []
    for t in token
        if t in nums
            push!(out, t)
        elseif t in ops
            while !isempty(op) && op[end] != '(' && rank[op[end]] ≥ rank[t] 
                push!(out, pop!(op))
            end
            push!(op, t)
        elseif t == '('
            push!(op, t)
        elseif t == ')' 
            while op[end] != '('
                push!(out, pop!(op))
            end
            pop!(op)
        end
    end
    while !isempty(op)
        push!(out, pop!(op))
    end
    return join(" ".*(out))
end

function eval_rpn(rpnotation::AbstractString)

    stack =[]
    for t in map(eval, map(Meta.parse, split(rpnotation)))
        if isa(t, Function) && !isempty(stack)
            arg2 = pop!(stack)
            arg1 = pop!(stack)
            push!(stack, t(arg1, arg2))
        else
            push!(stack, t)
        end
    end
    return stack[1]
end

function solve(input = raw_input)
    lines = splitlines(input)
    (Part1=part1(lines), Part2=part2(lines))
end

function part1(lines)
    precedence = Dict('*' => 0, '+' => 0)
    result = []
    for l in lines
        rpnstring = rpn(l, precedence)
        push!(result, eval_rpn(rpnstring))
    end
    return sum(result)
end

function part2(lines)
    precedence = Dict('*' => 0, '+' => 1)
    result = []
    for l in lines
        rpnstring = rpn(l, precedence)
        push!(result, eval_rpn(rpnstring))
    end
    return sum(result)
end
end # module
