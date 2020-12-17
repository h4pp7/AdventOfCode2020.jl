module Day17
using AdventOfCode2020

const raw_data = readinput(joinpath(@__DIR__, "Day17_input.txt"))

function create_dim(input, samplesize)
    blueprints = reduce(vcat, permutedims.(collect.(split(input))))
    M = BitArray(zeros(samplesize))
    R = CartesianIndices(blueprints)
    for I in R
        blueprints[I] == '#' ? M[I] = 1 : M[I] = 0
    end
    return M
end

function step(M)
    A =  BitArray(zeros(size(M) .+ 2))
    out = copy(A)
    R = CartesianIndices(M)
    offset = CartesianIndex(first(R))
    O = R .+ offset
    copyto!(A, O, M, R)
    P = CartesianIndices(A)
    Ifirst, Ilast = first(P), last(P)
    I1 = oneunit(Ifirst)
    for I in P
        c = 0
        for J in max(Ifirst, I - I1):min(Ilast, I + I1)
            if A[J] == 1
                c += 1
            end
        end
        if A[I] == 1 && c in 3:4
            out[I] = 1
        elseif A[I] == 0 && c == 3
            out[I] = 1
        else
            out[I] = 0
        end
    end
    copy!(A, out)
    return A
end

function solve(data = raw_data)
    M3D = create_dim(data, (8,8,1))
    M4D = create_dim(data, (8,8,1,1))

    for i in 1:6
        M3D = step(M3D)
        M4D = step(M4D)
    end

    return (Part1=sum(M3D), Part2=sum(M4D))
end
end # module
