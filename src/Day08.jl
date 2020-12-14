module Day08
using AdventOfCode2020

# TODO rewrite with a struct for the system state, instead (or in addition to)
# passing the registers around

const raw_data = readinput(joinpath(@__DIR__, "Day08_input.txt"))

function acc(A, PC, operand)
    A += operand
    PC += 1
    return A, PC
end

function jmp(A, PC, operand)
    PC += operand  
    return A, PC
end

function nop(A, PC, operand)
    PC += 1
    return A, PC
end

const opcodes = Dict{String, Function}("acc" => acc, "jmp" => jmp, "nop" => nop)

function run(A, PC, C, lines)
    while PC ∉ C && PC <= length(lines)
        push!(C, PC) 
        l = lines[PC]
        operand = parse(Int, l[5:end])
        A, PC = opcodes[l[1:3]](A, PC, operand)::Tuple{Int,Int}
    end
    return A, PC
end

function solve(data = raw_data)
    A = 0
    PC = 1
    C = Array{Int,1}()
    lines = splitlines(raw_data)
    solution1, _ = run(A, PC, C, lines)
    solution2 = find_bug(lines)
    return (Part1=solution1, Part2=solution2)
end

function find_bug(lines = splitlines(raw_data))
    A = 0
    PC = 1
    C = Array{Int,1}()
    lines = splitlines(raw_data)
    run(A, PC, C, lines)

    nj = [i for i in C if lines[i][1:3] == "nop" || lines[i][1:3] == "jmp"]

    for i in nj
        A = 0
        PC = 1
        nC = similar(C)
        if lines[i][1:3] == "jmp" 
            lines[i] = replace(lines[i], "jmp" => "nop")
        else 
            lines[i] = replace(lines[i], "nop" => "jmp")
        end
        A, PC = run(A, PC, nC, lines)
        if PC == length(lines) + 1
            return A
        end
        if lines[i][1:3] == "jmp" 
            lines[i] = replace(lines[i], "jmp" => "nop")
        else 
            lines[i] = replace(lines[i], "nop" => "jmp")
        end
    end
    return nothing
end
end # module
