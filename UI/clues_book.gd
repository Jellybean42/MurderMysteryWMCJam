extends Control

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_focus_next"):
		visible = not visible
		set_process_input(visible)
		
