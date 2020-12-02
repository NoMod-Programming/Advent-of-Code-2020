//usr/bin/go run $0 $@ ; exit

/*
 * Advent of Code 2020 Solution - Golang
 */

package main

import (
	"fmt"
	"strings"
	"strconv"
	"io/ioutil"
)

func ValidSledPasswords(passwordLines []string) int {
	validPasswords := 0

	for _, passwordLine := range passwordLines {
		if passwordLine == "" { continue } // Ignore empty lines

		splitPolicyLine := strings.Split(passwordLine, ":")
		policy, password := splitPolicyLine[0], splitPolicyLine[1]

		policyPart := strings.Split(policy, " ")
		letterRequirement := policyPart[1]
		letterRange := strings.Split(policyPart[0], "-")
		lowerBound, err := strconv.Atoi(letterRange[0])
		checkError(err)
		upperBound, err := strconv.Atoi(letterRange[1])
		checkError(err)

		letterOccurences := strings.Count(password, letterRequirement)

		if (letterOccurences <= upperBound) && (letterOccurences >= lowerBound) {
			validPasswords++
		}
	}

	return validPasswords
}

func ValidTobogganPasswords(passwordLines []string) int {
	validPasswords := 0

	for _, passwordLine := range passwordLines {
		if passwordLine == "" { continue } // Ignore empty lines

		splitPolicyLine := strings.Split(passwordLine, ":")
		policy, password := splitPolicyLine[0], splitPolicyLine[1]

		policyPart := strings.Split(policy, " ")
		letterRequirement := policyPart[1]
		letterRange := strings.Split(policyPart[0], "-")

		// Neither needs to be changed, since we split the password line
		// at ":", and therefore have a space that automagically makes everything
		// one-indexed for us
		lowerRequirement, err := strconv.Atoi(letterRange[0])
		checkError(err)
		upperRequirement, err := strconv.Atoi(letterRange[1])
		checkError(err)

		hasUpperLetter := string(password[lowerRequirement]) == letterRequirement
		hasLowerLetter := string(password[upperRequirement]) == letterRequirement

		if hasUpperLetter != hasLowerLetter {
			validPasswords++
		}
	}

	return validPasswords
}

func checkError(err error) {
	if err != nil {
		panic(err)
	}
}

func main() {
	inputFile, err := ioutil.ReadFile("input")
	checkError(err)
	passwordLines := strings.Split(string(inputFile), "\n")


	fmt.Println("Part 1 answer:", ValidSledPasswords(passwordLines))
	fmt.Println("Part 2 answer:", ValidTobogganPasswords(passwordLines))
}
