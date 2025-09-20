extends Camera3D

var target_position : Vector3
var target_rotation : float

# How fast the camera moves/rotates to the target
@export var move_speed : float = 5.0
@export var rotate_speed : float = 5.0

func camera_position(loc : Vector3, rot : float):
	target_position = loc
	target_rotation = rot

func _process(delta: float) -> void:
	# Smoothly move towards the target position
	global_position = global_position.lerp(target_position, move_speed * delta)
	
	# Smoothly rotate towards the target rotation (Y axis only)
	global_rotation.y = lerp_angle(global_rotation.y, target_rotation, rotate_speed * delta)
