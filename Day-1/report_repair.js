#!/usr/bin/env node

// Advent of Code 2020 Solution - Nodejs

function find_numbers_with_sum(numbers, sum) {
	let startNum = 0;
	let endNum = numbers.length - 1;

	for (let i = 0; i < numbers.length - 1; i++) {
		let tempSum = numbers[startNum] + numbers[endNum];
		if (tempSum > sum) endNum -= 1;
		if (tempSum < sum) startNum += 1;
		if (tempSum == sum) return [numbers[startNum], numbers[endNum]];
	}
}

function find_three_numbers_with_sum(numbers, sum) {
	let endNum = numbers.length - 1;

	for (let i = 0; i < numbers.length - 1; i++) {
		let innerStartNum = 0;
		let innerEndNum = endNum - 1;

		for (let j = 0; j < endNum - 1; j++) {
			let tempSum = numbers[innerStartNum] + numbers[innerEndNum] + numbers[endNum];
			if (tempSum > sum) innerEndNum -= 1;
			if (tempSum < sum) innerStartNum += 1;
			if (tempSum == sum) return [numbers[innerStartNum], numbers[innerEndNum], numbers[endNum]];
		}

		endNum -= 1;
	}
}

var fs = require('fs');
var inputLines = fs.readFileSync('input', 'ascii').split(/\n/);
inputLines.pop(); // Remove blank line at the end
var numbers = inputLines.map(numStr => parseInt(numStr)).sort((a, b) => a - b);

console.log("Answer to part one:", find_numbers_with_sum(numbers, 2020).reduce((a, b) => a * b));
console.log("Answer to part two:", find_three_numbers_with_sum(numbers, 2020).reduce((a, b) => a * b));
