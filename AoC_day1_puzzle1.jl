io = read("AoC_day1_puzzle1_input", String)
nums = [parse(Int, n) for n in split(chop(io), "\n")]
solution = reduce(*, (x for x in nums, y in nums if x+y == 2020))
@info solution
