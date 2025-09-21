extends Control


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		visible = not visible
		set_process_input(visible)
		get_tree().paused = visible


func _on_button_button_up() -> void:
	visible = false


func _on_button_3_button_up() -> void:
	get_tree().quit()


func _on_button_2_button_up() -> void:
	pass # Replace with function body.
