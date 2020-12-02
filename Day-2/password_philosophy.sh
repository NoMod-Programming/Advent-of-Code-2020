#!/bin/bash

# Advent of Code 2020 Solution - bash

input_file="input"

if ! [ -e "$input_file" ] ; then
	echo "$0: $input_file does not exist" >&2
	exit 1
fi

IFS="\n" readarray password_lines < "$input_file"

function valid_sled_passwords {
	valid_passwords=0

	for line_no in "${!password_lines[@]}" ; do
		IFS=":" read -a split_policy_line <<< "${password_lines[$line_no]}"
		policy="${split_policy_line[0]}"
		password="${split_policy_line[1]}"

		IFS=" " read -d '' -a policy_part <<< "${policy}"
		letter_requirement="${policy_part[1]}"
		IFS="-" read -d '' -a letter_range <<< "${policy_part[0]}"
		range_start="${letter_range[0]}"
		range_end="${letter_range[1]}"

		letter_occurences=$(echo "$password" | grep -o "$letter_requirement" | wc -l)

		if ((letter_occurences >= range_start && letter_occurences <= range_end)); then
			valid_passwords=$(expr "$valid_passwords" + 1)
		fi
	done

	echo "Solution to part 1: $valid_passwords"
}

function valid_toboggan_passwords {
	valid_passwords=0

	for line_no in "${!password_lines[@]}" ; do
		IFS=":" read -a split_policy_line <<< "${password_lines[$line_no]}"
		policy="${split_policy_line[0]}"
		password="${split_policy_line[1]}"

		IFS=" " read -a policy_part <<< "${policy}"
		letter_requirement="${policy_part[1]}"
		IFS="-" read -a letter_range <<< "${policy_part[0]}"
		range_start=$(expr "${letter_range[0]}" + 1)
		range_end=$(expr "${letter_range[1]}" + 1)

		has_upper_letter=0; [[ $(expr substr "$password" "$range_start" 1) == "$letter_requirement" ]] && has_upper_letter=1
		has_lower_letter=0; [[ $(expr substr "$password" "$range_end" 1) == "$letter_requirement" ]] && has_lower_letter=1

		if [[ "$has_upper_letter" -ne "$has_lower_letter" ]]; then
			valid_passwords=$(expr "$valid_passwords" + 1)
		fi
	done

	echo "Solution to part 2: $valid_passwords"
}


valid_sled_passwords
valid_toboggan_passwords
