#!/usr/bin/env python3
from typing import List

def find_numbers_with_sum(numbers: List[int], sum: int) -> (int, int):
    """Find two numbers in the ordered list with the specified sum.

    Arguments:
    numbers -- the ordered list of numbers to search through
    sum     -- the sum that two numbers should add up to

    This is a relatively simple algorithm to find two numbers (if they exist)
    with a specific sum. Provided the list is in order, we can start by adding
    the two numbers at the end of the list and comparing it to the desired sum.

    If both numbers add up to more than the desired sum, then we can get a smaller sum
    by choosing the second-largest number instead of the largest one.

    Similarly, if both numbers add up to less than the desired sum, then we can get a
    larger sum by choosing the second-smallest number instead of the smallest one. That
    is repeated until two numbers with the specified sum are found or until the list is
    exhausted.

    By "closing in" on the range of numbers, we don't end up trying every possible pair
    of numbers in the list, with a complexity of O(n^2). This algorithm runs with a
    complexity of O(n) instead*. (* = it's been a while since I've done Big-O
    notation, feel free to correct me with a pull request)
    """
    start_num = 0
    end_num = len(numbers) - 1
    for i in range(end_num):
        if (numbers[start_num] + numbers[end_num]) > sum:
            end_num -= 1
        elif (numbers[start_num] + numbers[end_num]) < sum:
            start_num += 1
        elif (numbers[start_num] + numbers[end_num]) == sum:
            return (numbers[start_num], numbers[end_num])
    raise RuntimeError("No two numbers sum to {}".format(sum))


def find_three_numbers_with_sum(numbers: List[int], sum: int) -> (int, int):
    """Find three numbers in the ordered list with the specified sum.

    Arguments:
    numbers -- the ordered list of numbers to search through
    sum     -- the sum that three numbers should add up to

    This is a relatively simple algorithm to find three numbers (if they exist)
    with a specific sum. Provided the list is in order, we split the list at the
    last number, and use algorithm from find_two_numbers_with_sum() to find two
    numbers that, when added to the last, add up to the desired sum (the two numbers
    would just sum to [sum - last_number]).

    Similar to the algorithm from find_two_numbers_with_sum(), the algorithm works by
    "closing in" on the range of possible numbers. If no numbers add up to the desired
    sum, split the list at the second-to-last number, run the algorithm from
    find_two_numbers_with_sum on the first slice again. That is repeated until the three
    numbers with the specified sum are found or until the list is exhausted.

    By "closing in" on the range of numbers, we don't end up trying every possible pair
    of numbers in the list, with a complexity of O(n^3). This algorithm runs with a
    complexity of O(n^2) instead*. (* = it's been a while since I've done Big-O
    notation, feel free to correct me with a pull request)
    """
    end_num = len(numbers) - 1
    for i in range(len(numbers)):
        inner_start_num = 0
        inner_end_num = end_num - 1
        for i in range(inner_end_num):
            if (numbers[inner_start_num] + numbers[inner_end_num] + numbers[end_num]) > sum:
                inner_end_num -= 1
            elif (numbers[inner_start_num] + numbers[inner_end_num] + numbers[end_num]) < sum:
                inner_start_num += 1
            elif (numbers[inner_start_num] + numbers[inner_end_num] + numbers[end_num]) == sum:
                return (numbers[inner_start_num], numbers[inner_end_num], numbers[end_num])
        end_num -= 1
    raise RuntimeError("No three numbers sum to {}".format(sum))



if __name__ == '__main__':
    with open('input', 'r') as input_file:
        numbers = sorted(int(num) for num in input_file.read().splitlines())

    # Part one - Find two numbers that sum to 2020
    numberone, numbertwo = find_numbers_with_sum(numbers, 2020)
    print(f"Answer to part one: {numberone * numbertwo}")

    # Part two - Find three numbers that sum to 2020
    numberone, numbertwo, numberthree = find_three_numbers_with_sum(numbers, 2020)
    print(f"Answer to part two: {numberone * numbertwo * numberthree}")
