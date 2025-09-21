extends RichTextLabel
#regit
@export var letters: Array[String] = []
@export var startI: int

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_focus_next"):
		on_open()

func on_open() -> void:
	var count = 0
	for l in letters:
		if(Global.letter_flags[l]):
			text[3 + startI + count * 2] = l[0]
		count+=1
