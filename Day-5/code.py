#!/usr/bin/env python3
# Advent of Code 2020 Solution - Python

def seat_id_from_boarding_pass(boarding_pass):
    row = 0
    pass_row = boarding_pass[:7]
    for char in pass_row:
        row *= 2
        if char == 'B':
            row += 1

    column = 0
    pass_column = boarding_pass[7:]
    for char in pass_column:
        column *= 2
        if char == 'R':
            column += 1

    return (row * 8) + column


if __name__ == '__main__':
    with open("input", "r") as input_file:
        boarding_passes = input_file.read().split('\n')
    boarding_passes.pop() # Remove final empty line

    all_seat_ids = [seat_id_from_boarding_pass(boarding_pass) for boarding_pass in boarding_passes]
    print(f"Answer to part 1: {max(all_seat_ids)}")

    lowest_id = min(all_seat_ids)
    highest_id = max(all_seat_ids)
    empty_seats = [sid for sid in range(lowest_id, highest_id) if sid not in all_seat_ids]
    my_seat = empty_seats[0] # Full flight
    print(f"Answer to part 2: {my_seat}")
