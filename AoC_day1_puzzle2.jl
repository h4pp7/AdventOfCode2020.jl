io = read("AoC_day1_puzzle1_input", String)
nums = [parse(Int, n) for n in split(chop(io), "\n")]
solution = reduce(*, [[x, y, z] for x in nums, y in nums, z in nums if x+y+z == 2020][1])
@info solution
