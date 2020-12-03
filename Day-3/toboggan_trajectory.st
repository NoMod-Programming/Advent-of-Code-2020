#!/usr/bin/gst -f
"=============================================================
|
|  Advent of Code 2020 Solution - GNU Smalltalk
|
=============================================================="

Object subclass: TobogganTrajectory [
	| terrain |

	TreeSymbol := $#.

	on: terrainMap [
		terrain := terrainMap
	]

	treesEncounteredRight: right down: down [
		| xOffset yOffset path |
		xOffset := 0.
		yOffset := 0.
		path := ''.

		[yOffset < terrain size] whileTrue: [
			| terrainLine |
			"The +1 is, annoyingly, to deal with Smalltalk's
			1-indexed-ness. Depending on the problem, it can be
			useful or annoying to deal with. This is a case of
			the latter."
			terrainLine := terrain at: (yOffset + 1).
			path := path, (terrainLine at: (xOffset + 1)) asString.

			xOffset := xOffset + right.
			yOffset := yOffset + down.

			xOffset := xOffset \\ terrainLine size
		].

		^ (path select: [:char | char = TreeSymbol]) size
	]

	TobogganTrajectory class [
		newOn: terrainMap [
			^ self new on: terrainMap
		]
	]
]

Eval [
	"Load the input file into the passwordList variable"
	inputFile := FileStream open: 'input' mode: FileStream read.
	terrain := OrderedCollection new.
	inputFile lines do: [:line | terrain add: line].
	inputFile close.


	trajectory := TobogganTrajectory newOn: terrain.

	'Answer to part 1: ' display.
	(trajectory treesEncounteredRight: 3 down: 1) displayNl.

	'Answer to part 2: ' display.
	treesPerTrajectory := {
		trajectory treesEncounteredRight: 1 down: 1.
		trajectory treesEncounteredRight: 3 down: 1.
		trajectory treesEncounteredRight: 5 down: 1.
		trajectory treesEncounteredRight: 7 down: 1.
		trajectory treesEncounteredRight: 1 down: 2}.

	(treesPerTrajectory fold: [:a :b | a * b]) displayNl
]
