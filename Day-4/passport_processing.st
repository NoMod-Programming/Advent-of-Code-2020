#!/usr/bin/gst -f
"=============================================================
|
|  Advent of Code 2020 Solution - GNU Smalltalk
|
=============================================================="

Object subclass: PassportProcessing [

	| passportFields |

	MandatoryFields := {'byr'. 'iyr'. 'eyr'. 'hgt'. 'hcl'. 'ecl'. 'pid'} asSet.
	ValidEyeColors := {'amb'. 'blu'. 'brn'. 'gry'. 'grn'. 'hzl'. 'oth'}.

	HeightRegex := '^(\d+)(\w+)$'.
	HairColorRegex := '^#[0-9a-f]{6}$'.
	PassportIdRegex := '^\d{9}$'.

	"Initialization"
	initialize [
		passportFields := Dictionary new
	]

	from: aString [
		| passportAssociations |
		passportAssociations := aString subStrings.
		passportAssociations do: [:dataPair |
			| assoc |
			assoc := dataPair subStrings: $:.
			passportFields at: assoc first put: assoc second
		]
	]

	"Testing"
	hasValidStructure [
		^ passportFields keys >= MandatoryFields
	]

	hasValidHeight [
		| hgt |
		hgt := passportFields at: 'hgt'.
		(hgt =~ HeightRegex) ifMatched: [:match |
			(match at: 2) = 'in' ifTrue: [
				"Inches must be between 59 and 76"
				| hgtIn |
				hgtIn := (match at: 1) asNumber.
				^ (59 <= hgtIn) & (hgtIn <= 76)
			].
			(match at: 2) = 'cm' ifTrue: [
				| hgtCm |
				"Centimeters must be between 105 amd 193"
				hgtCm := (match at: 1) asNumber.
				^ (105 <= hgtCm) & (hgtCm <= 193)
			].
		].
		^ false
	]

	hasValidData [
		| byr iyr eyr ecl hcl pid |
		self hasValidStructure ifFalse: [^ false].

		byr := (passportFields at: 'byr') asNumber.
		(1920 <= byr) & (byr <= 2002) ifFalse: [^ false].

		iyr := (passportFields at: 'iyr') asNumber.
		(2010 <= iyr) & (iyr <= 2020) ifFalse: [^ false].

		eyr := (passportFields at: 'eyr') asNumber.
		(2020 <= eyr) & (eyr <= 2030) ifFalse: [^ false].

		"Validate height"
		self hasValidHeight ifFalse: [^ false].

		ecl := passportFields at: 'ecl'.
		(ValidEyeColors includes: ecl) ifFalse: [^ false].

		hcl := passportFields at: 'hcl'.
		(hcl =~ HairColorRegex) ifNotMatched: [^ false].

		pid := passportFields at: 'pid'.
		(pid =~ PassportIdRegex) ifNotMatched: [^ false].

		^ true

	]


	PassportProcessing class [
		newFrom: aString [
			^ super new initialize; from: aString
		]
	]
]

Eval [
	"Load the input file into the passwordList variable"
	inputFile := FileStream open: 'input' mode: FileStream read.
	rawPassports := inputFile contents tokenize: '\n\n'.
	allPassports := rawPassports collect: [:passport | PassportProcessing newFrom: passport].
	inputFile close.

	validStructurePassports := allPassports select: [:passport | passport hasValidStructure].
	'Answer to part 1: ' display.
	validStructurePassports size displayNl.

	validDataPassports := validStructurePassports select: [:passport | passport hasValidData].
	'Answer to part 2: ' display.
	validDataPassports size displayNl
]
