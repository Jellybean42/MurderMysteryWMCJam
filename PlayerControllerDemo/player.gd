extends Node3D

@export var speed_side: float = 5.0   # fast
@export var speed_depth: float = 2.0  # slow

# Bounds in world space
@export var min_x: float = -5.0
@export var max_x: float =  5.0
@export var min_z: float = -3.0
@export var max_z: float =  3.0

var camera : Camera3D

var facing_angle := 0.0  # Track rotation in degrees

func _ready() -> void:
	camera = get_tree().get_first_node_in_group("camera")

func _physics_process(delta: float) -> void:
	var local_velocity := Vector3.ZERO

	# Interpret inputs first
	if Input.is_action_pressed("ui_left"):
		local_velocity.x -= speed_side
	if Input.is_action_pressed("ui_right"):
		local_velocity.x += speed_side
	if Input.is_action_pressed("ui_up"):
		local_velocity.z -= speed_depth
	if Input.is_action_pressed("ui_down"):
		local_velocity.z += speed_depth

	if local_velocity != Vector3.ZERO:
		# Transform local (relative to player) into world
		var world_velocity := basis * local_velocity
		global_translate(world_velocity * delta)

	# Clamp bounds
	global_position.x = clamp(global_position.x, min_x, max_x)
	global_position.z = clamp(global_position.z, min_z, max_z)

	## Rotate player + camera together
	#if Input.is_action_just_pressed("ui_select"):
		#facing_angle += 90.0
		#rotation_degrees.y = facing_angle
