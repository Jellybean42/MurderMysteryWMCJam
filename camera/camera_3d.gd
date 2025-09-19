extends Camera3D

@export var marker1 : Marker3D
@export var marker2 : Marker3D

func _ready() -> void:
	position = marker1.position


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		position = marker2.position


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		position = marker1.position
