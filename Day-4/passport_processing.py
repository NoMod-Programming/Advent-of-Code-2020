#!/usr/bin/env python3
import re

# Advent of Code 2020 Solution - Python

MANDATORY_PASSPORT_FIELDS = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
VALID_EYE_COLORS = ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth']

HAIR_COLOR_REGEX = r"^#[0-9a-f]{6}$"
PASSPORT_ID_REGEX = r"^\d{9}$"


def has_valid_passport_structure(passport):
    passport_associations = passport.split()
    passport_dict = dict(assoc.split(':') for assoc in passport_associations)

    # Validate passport structure
    # MUST have fields byr, iyr, eyr, hgt, hcl, ecl, and pid
    # MAY have cid field, but is optional, and can be safely ignored
    return all(field in passport_dict for field in MANDATORY_PASSPORT_FIELDS)


def has_valid_passport_data(passport):
    if not has_valid_passport_structure(passport):
        # Don't even consider it
        return False

    passport_associations = passport.split()
    passport_dict = dict(assoc.split(':') for assoc in passport_associations)

    def valid_height(height):
        height_no = int(height[:-2])
        height_suf = height[-2:]

        if height_suf == 'cm':
            return 150 <= height_no <= 193
        elif height_suf == 'in':
            return 59 <= height_no <= 76
        return False

    try:
        assert 1920 <= int(passport_dict['byr']) <= 2002
        assert 2010 <= int(passport_dict['iyr']) <= 2020
        assert 2020 <= int(passport_dict['eyr']) <= 2030
        assert valid_height(passport_dict['hgt'])
        assert passport_dict['ecl'] in VALID_EYE_COLORS
        assert re.match(HAIR_COLOR_REGEX, passport_dict['hcl'])
        assert re.match(PASSPORT_ID_REGEX, passport_dict['pid'])
        return True
    except AssertionError as _:
        return False


if __name__ == '__main__':
    with open("input", "r") as input_file:
        all_passports = input_file.read().split('\n\n')

    part_one_answer = sum(has_valid_passport_structure(passport) for passport in all_passports)
    print(f"Answer to part 1: {part_one_answer}")

    part_two_answer = sum(has_valid_passport_data(passport) for passport in all_passports)
    print(f"Answer to part 2: {part_two_answer}")
