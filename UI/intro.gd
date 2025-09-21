extends Control

func _ready():
	if(Global.introd):
		visible = false
	Global.introd = true


func _on_button_button_up() -> void:
	visible = false
