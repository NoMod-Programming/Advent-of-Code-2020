#!/usr/bin/env python3
# Advent of Code 2020 Solution - Python

def num_questions_with_any_yes(customs_forms):
    count = 0

    for group in customs_forms:
        responses_per_person = [set(line) for line in group.splitlines()]
        one_yes_questions = set.union(*responses_per_person)
        count += len(one_yes_questions)
    return count

def num_questions_with_all_yes(customs_forms):
    count = 0
    for group in customs_forms:
        responses_per_person = [set(line) for line in group.splitlines()]
        all_yes_questions = set.intersection(*responses_per_person)
        count += len(all_yes_questions)
    return count

if __name__ == '__main__':
    with open("input", "r") as input_file:
        customs_forms = input_file.read().split('\n\n')

    print(f"Answer to part 1: {num_questions_with_any_yes(customs_forms)}")
    print(f"Answer to part 2: {num_questions_with_all_yes(customs_forms)}")
