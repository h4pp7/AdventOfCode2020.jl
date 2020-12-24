# AdventOfCode2020.jl

## Overview
Julia Package with my attempt at [Advent of Code 2020](https://adventofcode.com/2020/).
Just for fun and for learning Julia (and programming in general).

As a soft rule I'm trying to only use Base packages, since I want to learn the
language.

The commits with the first submitted correct solutions for each day are tagged
with git tags. `v0.1` for day 1, `v0.2` for day 2 etc.

## Notes (to self)
### Day 17
I could reuse the core of Day 10, but simplified, because there are no cells,
who aren't alive or dead. Since I solved part 1 to work with arbitrary
dimensions, the second part only needed small changes. I'm growing the pocket
dim every step by 2. Would be nice if I could figure out a away to check the
"wall" cells, if any are alive and then grow only in that dimension. Haven't
found a way to do that and retain combatibility with arbitrary dimensions,
though. Maybe I can use [this idea](https://julialang.org/blog/2016/02/iteration/) for summing along a single
dimension...

### Day 18
Implemented half a [Shunting-yard
algorithm](https://en.wikipedia.org/wiki/Shunting-yard_algorithm). It converts
a string in infix notation to a string in reverse polish notation, but it can
only deal with '*' and '+'. I then evaluate that string by splitting it up and
mapping over it with Meta.parse and eval.

### Day 19
**unfinished**
TODO: complete implementing [CYK algorithm](https://en.wikipedia.org/wiki/CYK_algorithm). Eliminating unit rules is missing.

Solved part 2 by building a regex pattern. Just iterated over the rules and
replaced numbers by the rule text of the referenced rule until no numbers where
left.

### Day 20
**unfinished**
TODO: Actually build the map. The monster search function should work.

Solved part 1 bei not building the map and just storing the border tiles. Just brute force search for the corner tiles.

### Day 21
Make a dictionary from allergens to ingredients, with only the intersection of
all the ingredients listet for that allergen. Count all the ingredients not in
that dictionary for part 1. For part 2 I just reused Day 16. Go through the
dictionary, find the allergen that has only one ingredient listet, pop that
allergen out and into a confirmed list. Repeat until the dictionary is empty.

### Day 22
For part 1 just implemented the instructions step by step, basically. For part
2 call the function recursively in the while loop, when the condition for the
recursive game is met. Store the previous game turns to check for
non-terminating games. I tried pretty long to do it with a recursive call at
the end of the function instead of a while loop. But never could get the right
solution and had some weird interactions between the decks and their copies.

### Day 23
Naively implemented part 1. Instead of wrapping around I used `circularshift`
to rotate the contents of the vector, so that the current cup was always the
first element.

For part 2 used a vector like a linked list, where the indices represent the
cups and the value at a given index gives the index of the next cup. Tried to
find out for quite some time why it still ran for a minute without terminating
(before I stopped it). For some reason I put 1_000_000_000 as the size of the
vector and 10_000_000_000 as the number of steps. So 10^9 and 10^10 instead of
10^6 and 10^7 🤦

### Day 24
Made a struct as a wrapper around a dictionary from cube coordinates to
true/false for color. That way I have (0,0,0) as the origin coordinates and I
can parse and reduce the paths to relative coordinates. [This website](https://www.redblobgames.com/grids/hexagons) 
about hexagonal grids is amazing. The getfunction for the struct returns
`false` as default, that way I don't have to bother about extending. The struct
is not really needed, I could use the dict directly, but it makes it a bit more
convenient and I wanted to learn more about custom Types. I initially wanted to
make a real custom AbstractArray with negative indexing etc (c.f. 
[Arrays with custom indices](https://docs.julialang.org/en/v1/devdocs/offset-arrays/#man-custom-indices))
but kept it simple in the end.
