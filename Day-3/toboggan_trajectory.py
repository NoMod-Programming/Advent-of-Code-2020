#!/usr/bin/env python3
from functools import reduce
from operator import mul

# Advent of Code 2020 Solution - Python

TREE_SYMBOL = '#'

def trees_encountered(terrain, right, down):
    x_offset = 0
    y_offset = 0

    path = ""

    while y_offset < len(terrain):
        terrain_line = terrain[y_offset]
        path += terrain_line[x_offset]

        # Compute the new position
        x_offset += right
        y_offset += down
        # Wrap around the terrain if needed
        x_offset %= len(terrain_line)

    return path.count(TREE_SYMBOL)


if __name__ == '__main__':
    with open("input", "r") as input_file:
        terrain = input_file.read().splitlines()


    print(f"Answer to part 1: {trees_encountered(terrain, 3, 1)}")

    print("Answer to part 2: {}".format(
        reduce(mul, [
                trees_encountered(terrain, 1, 1),
                trees_encountered(terrain, 3, 1),
                trees_encountered(terrain, 5, 1),
                trees_encountered(terrain, 7, 1),
                trees_encountered(terrain, 1, 2)
            ], 1)
    ))
