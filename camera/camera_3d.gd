extends Camera3D

@export var marker1: Marker3D
@export var marker2: Marker3D
@export var lerp_speed: float = 3.0

@onready var room_1: Node3D = $".."

var target_position: Vector3
var target_rotation: Vector3

#func _ready() -> void:
	## Start at marker1
	#position = marker1.position
	#rotation = marker1.rotation
	#target_position = marker1.position
	#target_rotation = marker1.rotation
#
#func _process(delta: float) -> void:
	## Smoothly interpolate towards the target
	#position = position.lerp(target_position, delta * lerp_speed)
	#rotation.x = lerp_angle(rotation.x, target_rotation.x, delta * lerp_speed)
	#rotation.y = lerp_angle(rotation.y, target_rotation.y, delta * lerp_speed)
	#rotation.z = lerp_angle(rotation.z, target_rotation.z, delta * lerp_speed)

#func _on_area_3d_body_exited(body: Node3D) -> void:
	#if body.is_in_group("player"):
		#target_position = marker1.position
		#target_rotation = marker1.rotation
		#room_1.hide_main()
		#room_1.show_other()
		#print("do a thing")

#func _on_area_3d_body_entered(body: Node3D) -> void:
	#if body.is_in_group("player"):
		#target_position = marker2.position
		#target_rotation = marker2.rotation
		#room_1.show_main()
		#room_1.hide_other()
		#print("do other thing")
