using StrFormat

function init()
    for i = 1:26
        dir_name = f"day\%02d(i)"
        input_name = f"day\%02d(i)/day\%02d(i)_input.txt"
        solution_name = f"day\%02d(i)/day\%02d(i).jl"

        if ispath(dir_name) == false
            mkdir(dir_name)
        end
        if ispath(input_name) == false
            touch(input_name)
        end
        if ispath(solution_name) == false
			touch(solution_name)
            open(solution_name, "w") do io
                write(io, f"""module Day\%02d(i)

include("../main.jl")

function part1()
	data
end

function part2()
    data
end

end # module""")

            end
        end
    end
end
