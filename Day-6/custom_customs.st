#!/usr/bin/gst -f
"=============================================================
|
|  Advent of Code 2020 Solution - GNU Smalltalk
|
=============================================================="

Object subclass: CustomCustoms [
	CustomCustoms class [
		numQuestionsWithAnyYes: customsForms [
			| count |
			count := 0.

			customsForms do: [:group |
				| responsesPerPerson oneYesQuestions |
				responsesPerPerson := group lines collect: [:m | m asSet].
				oneYesQuestions := responsesPerPerson fold: [:a :b | a + b].
				count := count + oneYesQuestions size
			].

			^ count
		]

		numQuestionsWithAllYes: customsForms [
			| count |
			count := 0.

			customsForms do: [:group |
				| responsesPerPerson oneYesQuestions |
				responsesPerPerson := group lines collect: [:m | m asSet].
				oneYesQuestions := responsesPerPerson fold: [:a :b | a & b].
				count := count + oneYesQuestions size
			].

			^ count
		]
	]
]

Eval [
	"Load the input file into the passwordList variable"
	inputFile := FileStream open: 'input' mode: FileStream read.
	customsForms := inputFile contents tokenize: '\n\n'.
	inputFile close.

	'Answer to part 1: ' display.
	(CustomCustoms numQuestionsWithAnyYes: customsForms) displayNl.

	'Answer to part 2: ' display.
	(CustomCustoms numQuestionsWithAllYes: customsForms) displayNl.
]
