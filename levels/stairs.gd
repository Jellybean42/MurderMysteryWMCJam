extends Area3D

@export var marker : Marker3D

@onready var player: CharacterBody3D = $"../Player"

var valid : bool = false

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		valid = true


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):	
		valid = false

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and valid:
		print(marker)
		player.global_position = marker.global_position
