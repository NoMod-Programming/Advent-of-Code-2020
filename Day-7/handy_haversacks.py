#!/usr/bin/env python3
# Advent of Code 2020 Solution - Python
from collections import namedtuple
import re


ELEMENT_REGEX = "\s?(\d)\s(.*?)s?\.?\s?$"

BagElement = namedtuple('BagElement', ['number', 'bag_type'])


class HandyHaversacks(object):
    def __init__(self, bag_definitions):
        self.bag_elements = {}

        for definition in bag_definitions:
            outer_bag, sub_bags = definition.split("s contain ")
            bag_elements = set()

            if sub_bags != "no other bags.":
                for bag_type in sub_bags.split(','):
#                    print(bag_type, ELEMENT_REGEX)
                    bag_type_match = re.match(ELEMENT_REGEX, bag_type).groups()
                    bag_elements.add(BagElement(*bag_type_match))

            self.bag_elements[outer_bag] = bag_elements

    def bags_that_eventually_contain(self, wanted_bag_type):
        def has_sub_bag(current_bag_type):
            sub_bag_names = [sub_bag.bag_type for sub_bag in self.bag_elements[current_bag_type]]

            current_bag_has_wanted = wanted_bag_type in sub_bag_names
            sub_bags_have_wanted = any(has_sub_bag(sub_bag) for sub_bag in sub_bag_names)
            return current_bag_has_wanted or sub_bags_have_wanted

        return sum(has_sub_bag(bag_name) for bag_name in self.bag_elements)


    def num_bags_inside(self, wanted_bag_type):
        count = 0
        for bag in self.bag_elements[wanted_bag_type]:
            inside_bags = self.num_bags_inside(bag.bag_type)
            inside_bags *= int(bag.number)

            inside_bags += int(bag.number) # Include the bags themselves

            count += inside_bags

        return count


if __name__ == '__main__':
    with open("input", "r") as input_file:
        bag_definitions = input_file.read().split('\n')
    bag_definitions.pop()

    haversacks = HandyHaversacks(bag_definitions)

    print(f"Answer to part 1: {haversacks.bags_that_eventually_contain('shiny gold bag')}")
    print(f"Answer to part 2: {haversacks.num_bags_inside('shiny gold bag')}")
