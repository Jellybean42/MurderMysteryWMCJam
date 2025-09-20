extends Node3D

@onready var other_side: Node3D = $CSGCombiner3D/OtherSide
@onready var main_side: CSGBox3D = $CSGCombiner3D/MainSide


@onready var main_marker: Marker3D = $MainMarker
@onready var other_side_marker: Marker3D = $OtherSideMarker

var camera : Camera3D
var player : CharacterBody3D

func _ready() -> void:
	camera = get_tree().get_first_node_in_group("camera")
	player = get_tree().get_first_node_in_group("player")

func _on_stairs_body_entered(body: Node3D) -> void:
	main_side.show()
	other_side.hide()
	if camera.has_method("camera_position"):
		camera.camera_position(other_side_marker.global_position, other_side_marker.global_rotation.y)
		
	player.global_rotation.y = other_side_marker.global_rotation.y


func _on_room_body_entered(body: Node3D) -> void:
	main_side.hide()
	other_side.show()
	if camera.has_method("camera_position"):
		camera.camera_position(main_marker.global_position, main_marker.global_rotation.y)
		
		player.global_rotation.y = main_marker.global_rotation.y
