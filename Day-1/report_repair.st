#!/usr/bin/gst -f
"=============================================================
|
|  Advent of Code 2020 Solution - GNU Smalltalk
|
|  This isn't meant to stand alone, it's almost a direct-copy
|  Of the code in report_repair.py. See the comments there
|  For an explanation of the algorithm used
|
=============================================================="

Object subclass: ReportRepair [
	ReportRepair class [
		findTwoNumbersIn: numbersCollection withSum: wantedSum [
			| startNum endNum |
			startNum := 1.
			endNum := numbersCollection size.

			1 to: endNum do: [:i |
				| tempSum |
				tempSum := (numbersCollection at: startNum) + (numbersCollection at: endNum).
				tempSum > wantedSum ifTrue: [
					endNum := endNum - 1
				].
				tempSum < wantedSum ifTrue: [
					startNum := startNum + 1
				].
				tempSum = wantedSum ifTrue: [
					^ {numbersCollection at: startNum.
					   numbersCollection at: endNum}
				]
			]
		]

		findThreeNumbersIn: numbersCollection withSum: wantedSum [
			| endNum |
			endNum := numbersCollection size.
			1 to: endNum do: [:i |
				| innerStartNum innerEndNum |
				innerStartNum := 1.
				innerEndNum := endNum - 1.
				1 to: innerEndNum do: [:j |
					| tempSum |
					tempSum := (numbersCollection at: innerStartNum) + (numbersCollection at: innerEndNum) + (numbersCollection at: endNum).
					tempSum > wantedSum ifTrue: [
						innerEndNum := innerEndNum - 1
					].
					tempSum < wantedSum ifTrue: [
						innerStartNum := innerStartNum + 1
					].
					tempSum = wantedSum ifTrue: [
						^ {numbersCollection at: innerStartNum.
						   numbersCollection at: innerEndNum.
						   numbersCollection at: endNum}
					]
				].
				endNum := endNum - 1
			]
		]
	]
]

Eval [
	"Load the input file into the numbers variable, and sort it"
	inputFile := FileStream open: 'input' mode: FileStream read.
	numbers := OrderedCollection new.
	inputFile linesDo: [:line |
		numbers add: (line asNumber)
	].
	inputFile close.
	numbers sort.


	twoNums := ReportRepair findTwoNumbersIn: numbers withSum: 2020.
	(twoNums fold: [:a :b | a * b]) displayNl.

	threeNums := ReportRepair findThreeNumbersIn: numbers withSum: 2020.
	(threeNums fold: [:a :b | a * b]) displayNl
]
