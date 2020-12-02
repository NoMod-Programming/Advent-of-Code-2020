#!/bin/bash

# Advent of Code 2020 Solution - bash
#
# This isn't meant to stand alone, it's almost a direct copy
# Of the code in report_repair.py. See the comments there
# For an explanation of the algorithm used

input_file="input"

if ! [ -e "$input_file" ] ; then
	echo "$0: $input_file does not exist" >&2
	exit 1
fi

#(sort "$input_file") | read -d '' -a nums
read -d '' -a unsorted_nums < "$input_file"

nums=()
IFS=$'\n' nums=($(sort -n <<<"${unsorted_nums[*]}")); unset IFS


function find_two_numbers_with_sum {
	sum=$1

	start_num=0
	end_num=$(expr "${#nums[@]}" - 1)

	for i in $(seq 1 "${#nums[@]}") ; do
		temp_sum=$(expr "${nums[$start_num]}" + "${nums[$end_num]}")
		if [[ "${temp_sum}" -gt "$sum" ]] ; then end_num=$(expr "$end_num" - 1); fi
		if [[ "${temp_sum}" -lt "$sum" ]] ; then start_num=$(expr "$start_num" + 1); fi
		if [[ "${temp_sum}" -eq "$sum" ]] ; then
			echo -n "Solution to part 1: "
			echo $(expr "${nums[$start_num]}" "*" "${nums[$end_num]}")
			return
		fi
	done
}

function find_three_numbers_with_sum {
	sum=$1

	end_num=$(expr "${#nums[@]}" - 1)

	for i in $(seq 1 "${#nums[@]}") ; do
		inner_start_num=0
		inner_end_num=$(expr "$end_num" - 1)

		for j in $(seq 1 "$inner_end_num") ; do
			temp_sum=$(expr "${nums[$inner_start_num]}" + "${nums[$inner_end_num]}" + "${nums[$end_num]}")
			if [[ "${temp_sum}" -gt "$sum" ]] ; then inner_end_num=$(expr "$inner_end_num" - 1); fi
			if [[ "${temp_sum}" -lt "$sum" ]] ; then inner_start_num=$(expr "$inner_start_num" + 1); fi
			if [[ "${temp_sum}" -eq "$sum" ]] ; then
				echo -n "Solution to part 2: "
				echo $(expr "${nums[$inner_start_num]}" "*" "${nums[$inner_end_num]}" "*" "${nums[$end_num]}")
				return
			fi
		done

		end_num=$(expr "$end_num" - 1)
	done
}


find_two_numbers_with_sum 2020
find_three_numbers_with_sum 2020
