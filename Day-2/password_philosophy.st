#!/usr/bin/gst -f
"=============================================================
|
|  Advent of Code 2020 Solution - GNU Smalltalk
|
=============================================================="

Object subclass: PasswordPolicy [
	| passwordList |

	on: passwords [
		passwordList := passwords
	]

	validSledPasswords [
		| validPasswords |
		validPasswords := 0.
		passwordList do: [:passwordLine |
			| password letterRequirement rangeValues letterOccurences
			  splitPolicyLine |

			splitPolicyLine := passwordLine subStrings: ': '.
			
			password := splitPolicyLine last.

			letterRequirement := splitPolicyLine second first.
			rangeValues := (splitPolicyLine first subStrings: '-') collect: [:i | i asNumber].

			letterOccurences := (password select: [:char | char = letterRequirement]) size.
			
			(letterOccurences >= rangeValues first) & (letterOccurences <= rangeValues last) ifTrue: [
				validPasswords := validPasswords + 1
			]
		].
		^ validPasswords
	]

	validTobogganPasswords [
		| validPasswords |
		validPasswords := 0.
		passwordList do: [:passwordLine |
			| password letterRequirement rangeValues letterOccurences
			  splitPolicyLine |

			splitPolicyLine := passwordLine subStrings: ': '.
			
			password := splitPolicyLine last.

			letterRequirement := splitPolicyLine second first.
			rangeValues := (splitPolicyLine first subStrings: '-') collect: [:i | i asNumber].

			(((password at: rangeValues first) = letterRequirement) xor: ((password at: rangeValues second) = letterRequirement)) ifTrue: [
				validPasswords := validPasswords + 1
			]
		].
		^ validPasswords
	]

	PasswordPolicy class [
		newOn: passwords [
			^ self new on: passwords
		]
	]
]

Eval [
	"Load the input file into the passwordList variable"
	inputFile := FileStream open: 'input' mode: FileStream read.
	passwordList := OrderedCollection new.
	inputFile linesDo: [:line |
		passwordList add: line
	].
	inputFile close.


	policy := PasswordPolicy newOn: passwordList.

	'Answer to part 1: ' display.
	policy validSledPasswords displayNl.

	'Answer to part 2: ' display.
	policy validTobogganPasswords displayNl.
]
