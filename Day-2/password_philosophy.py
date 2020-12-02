#!/usr/bin/env python3
from typing import List

# Advent of Code 2020 Solution - Python

def valid_sled_passwords(password_list):
    valid_passwords = 0

    for password_line in password_list:
        policy, password = password_line.split(':')

        range, letter_requirement = policy.split(' ')
        lower_bound, upper_bound = [int(value) for value in range.split('-')]

        letter_occurences = password.count(letter_requirement)

        if lower_bound <= letter_occurences <= upper_bound:
            valid_passwords += 1

    return valid_passwords

def valid_toboggan_passwords(password_list):
    valid_passwords = 0

    for password_line in password_list:
        policy, password = password_line.split(':')
        password = list(password) # Easier to work with here

        range, letter_requirement = policy.split(' ')

        # Get range, Indices don't need to be changed since the space at the
        # beginning of the password (since we split at :) takes care of that for us
        lower_requirement, upper_requirement =  [int(value) for value in range.split('-')]

        has_upper_letter = password[upper_requirement] == letter_requirement
        has_lower_letter = password[lower_requirement] == letter_requirement

        if has_upper_letter != has_lower_letter:
            valid_passwords += 1

    return valid_passwords



if __name__ == '__main__':
    with open("input", "r") as inputfile:
        password_list = inputfile.read().splitlines()

    print(f"Answer to part 1: {valid_sled_passwords(password_list)}")
    print(f"Answer to part 2: {valid_toboggan_passwords(password_list)}")
