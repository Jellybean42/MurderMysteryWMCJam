extends RichTextLabel

var strings = ["The photo of the church seems to be hiding a secret",
 				"The things on the ground look strange",
			 	"What is the poem in the backpack"]

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		text = strings[randi() % strings.size()]
		
