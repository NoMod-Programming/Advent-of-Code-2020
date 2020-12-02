//usr/bin/go run $0 $@ ; exit

/*
 * Advent of Code 2020 Solution - Golang
 *
 * This isn't meant to stand alone, it's almost a direct copy
 * Of the code in repor_repair.py. See the comments there
 * For an explanation of the algorithm used
 */

package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"sort"
)

type NoSumError struct {
	desiredSum int
	explanation string
}

func (e *NoSumError) Error() string {
	return fmt.Sprintf("%s - %d", e.explanation, e.desiredSum)
}


func FindTwoNumbersWithSum(numbers []int, sum int) ([]int, error) {
	startNum := 0
	endNum := len(numbers) - 1
	for i := 0; i < endNum; i++ {
		tempSum := numbers[startNum] + numbers[endNum]
		if tempSum > sum { endNum -= 1 }
		if tempSum < sum { startNum += 1 }
		if tempSum == sum {
			twoNumbers := make([]int, 2, 2)
			twoNumbers[0] = numbers[startNum]
			twoNumbers[1] = numbers[endNum]
			return twoNumbers, nil
		}
	}
	return nil,&NoSumError{sum, "unable to find numbers with desired sum"}
}

func FindThreeNumbersWithSum(numbers []int, sum int) ([]int, error) {
	endNum := len(numbers) - 1
	for i := 0; i < len(numbers) - 1; i++ {
		innerStartNum := 0
		innerEndNum := endNum - 1
		for j := 0; j < (endNum - 1); j++ {
			tempSum := numbers[innerStartNum] + numbers[innerEndNum] + numbers[endNum]
			if tempSum > sum { innerEndNum -= 1 }
			if tempSum < sum { innerStartNum += 1 }
			if tempSum == sum {
				threeNumbers := make([]int, 3, 3)
				threeNumbers[0] = numbers[innerStartNum]
				threeNumbers[1] = numbers[innerEndNum]
				threeNumbers[2] = numbers[endNum]
				return threeNumbers, nil
			}
		}
		endNum -= 1
	}
	return nil,&NoSumError{sum, "unable to find numbers with desired sum"}
}

func prod(array []int) int {
	result := 1
	for _, eachNum := range array {
		result *= eachNum
	}
	return result
}

func checkError(err error) {
	if err != nil {
		panic(err)
	}
}

func main() {
	inputFile, err := os.Open("input")
	checkError(err)

	scanner := bufio.NewScanner(inputFile)
	scanner.Split(bufio.ScanWords)

	var numbers []int;
	for scanner.Scan() {
		eachNum, err := strconv.Atoi(scanner.Text())
		checkError(err) // Something went horribly wrong if there are more than numbers here
		numbers = append(numbers, eachNum)
	}

	sort.Ints(numbers)

	twoNums, err := FindTwoNumbersWithSum(numbers, 2020)
	checkError(err)
	fmt.Println("Answer to part one:", prod(twoNums))

	threeNums, err := FindThreeNumbersWithSum(numbers, 2020)
	checkError(err)
	fmt.Println("Answer to part two:", prod(threeNums))

}
