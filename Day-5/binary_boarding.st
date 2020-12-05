#!/usr/bin/gst -f
"=============================================================
|
|  Advent of Code 2020 Solution - GNU Smalltalk
|
=============================================================="

Object subclass: PassportProcessing [
	PassportProcessing class [
		seatIdFromBoardingPass: boardingPass [
			| row passRow column passColumn |
			row := 0.
			passRow := boardingPass copyFrom: 1 to: 7.
			passRow do: [:char |
				row := row * 2.
				char == $B ifTrue: [
					row := row + 1
				]
			].

			column := 0.
			passColumn := boardingPass copyFrom: 8 to: 10.
			passColumn do: [:char |
				column := column * 2.
				char == $R ifTrue: [
					column := column + 1
				]
			].

			^ (row * 8) + column
		]
	]
]

Eval [
	"Load the input file into the passwordList variable"
	inputFile := FileStream open: 'input' mode: FileStream read.
	boardingPasses := inputFile contents tokenize: '\n'.
	allPassports := boardingPasses collect: [:pass |
		PassportProcessing seatIdFromBoardingPass: pass
	].
	inputFile close.

	
	allPassports sort.
	'Answer to part 1: ' display.
	allPassports last displayNl.

	'Answer to part 2: ' display.
	minSid := allPassports first.
	maxSid := allPassports last.
	emptySeats := (minSid to: maxSid) select: [:sid | (allPassports includes: sid) not].
	emptySeats first displayNl.
]
