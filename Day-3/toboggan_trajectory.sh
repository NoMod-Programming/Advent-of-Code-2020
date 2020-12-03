#!/bin/bash

# Advent of Code 2020 Solution - bash

input_file="input"

if ! [ -e "$input_file" ] ; then
	echo "$0: $input_file does not exist" >&2
	exit 1
fi

IFS="\n" readarray terrain < "$input_file"

TREE_SYMBOL="#"

right_delta=3
down_delta=1

function calc_encountered_trees {
	x_offset=0
	y_offset=0

	path=""

	while [[ y_offset -lt "${#terrain[@]}" ]] ; do
		# Need to make the x-offset one-indexed here
		((one_indexed_x_offset = x_offset + 1))

		terrain_line="${terrain[$y_offset]}"
		path+=$(expr substr "$terrain_line" "$one_indexed_x_offset" 1)

		((x_offset += right_delta))
		((y_offset += down_delta))

		# -1 to account for a newline at the end of each line
		((x_offset %= "${#terrain_line}" - 1))
	done

	# This works provided there are no more than 255 trees
	return $(echo "$path" | grep -o "$TREE_SYMBOL" | wc -l)
}

calc_encountered_trees
echo "Answer to part 1: $?"


# A bit ugly, but it gets the job done for part 2: 
right_delta=1;down_delta=1
first_path=$(calc_encountered_trees; echo $?)

right_delta=3;down_delta=1
second_path=$(calc_encountered_trees; echo $?)

right_delta=5;down_delta=1
third_path=$(calc_encountered_trees; echo $?)

right_delta=7;down_delta=1
fourth_path=$(calc_encountered_trees; echo $?)

right_delta=1;down_delta=2
fifth_path=$(calc_encountered_trees; echo $?)

((part_two_answer = first_path * second_path * third_path * fourth_path * fifth_path))
echo "Answer to part 2: $part_two_answer"
