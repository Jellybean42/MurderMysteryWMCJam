extends Node

var player_transform: Transform3D
var letter_flags: Dictionary[String, bool] = {}

# Adds a key, automatically incrementing duplicates
func add_letter(letter: String, value: bool = false) -> void:
	var new_key = letter
	var counter = 2
	while letter_flags.has(new_key):
		new_key = letter + str(counter)
		counter += 1
	letter_flags[new_key] = value

func _ready():
	# Example usage: adding the first 15 letters
	var letters = "ADDBADHUMOURFUN"
	for letter in letters:
		add_letter(letter)
		
func find_letter(key: String) -> void:
	letter_flags[key] = true
