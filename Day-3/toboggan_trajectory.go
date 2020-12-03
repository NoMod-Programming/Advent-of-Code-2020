//usr/bin/go run $0 $@ ; exit

/*
 * Advent of Code 2020 Solution - Golang
 */

package main

import (
	"fmt"
	"strings"
	"io/ioutil"
)

var TreeSymbol = "#"

func TreesEncountered(terrain []string, right int, down int) int {
	x_offset := 0
	y_offset := 0

	path := ""

	for y_offset < len(terrain) {
		terrain_line := terrain[y_offset]
		if terrain_line == "" { break } // Empty line means we're done
		path += string(terrain_line[x_offset])

		x_offset += right
		y_offset += down

		x_offset %= len(terrain_line)
	}

	return strings.Count(path, TreeSymbol)
}

func checkError(err error) {
	if err != nil {
		panic(err)
	}
}

func main() {
	inputFile, err := ioutil.ReadFile("input")
	checkError(err)
	terrain := strings.Split(string(inputFile), "\n")


	fmt.Println("Answer to part 1:", TreesEncountered(terrain, 3, 1))
	fmt.Println("Answer to part 2:", (
		TreesEncountered(terrain, 1, 1) *
		TreesEncountered(terrain, 3, 1) *
		TreesEncountered(terrain, 5, 1) *
		TreesEncountered(terrain, 7, 1) *
		TreesEncountered(terrain, 1, 2)))
}
