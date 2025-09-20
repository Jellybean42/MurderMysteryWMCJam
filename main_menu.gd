extends Control

func _on_button_button_up() -> void:
	var game_scene = load("res://levels/present.tscn")
	get_tree().change_scene_to_packed(game_scene)


func _on_button_3_button_up() -> void:
	get_tree().quit()


func _on_button_2_button_up() -> void:
	pass # Replace with function body.
