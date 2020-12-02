module Day01

const input = read("day01/day01_input.txt", String)

function part1()
    nums = [parse(Int, n) for n in split(chop(input), "\n")]
    reduce(*, (x for x in nums, y in nums if x+y == 2020))
end

function part2()
    nums = [parse(Int, n) for n in split(chop(input), "\n")]
    reduce(*, 
        [[x, y, z] for x in nums, 
        y in nums, 
        z in nums if x+y+z == 2020][1]
      )
end

end # module
