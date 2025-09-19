extends Node3D

@export var speed_side: float = 5.0      # Left/right speed
@export var speed_depth: float = 2.0     # Up/down speed (slower)

# Bounds for movement (in world space)
@export var min_x: float = -5.0
@export var max_x: float =  5.0
@export var min_z: float = -3.0
@export var max_z: float =  3.0

func _physics_process(delta: float) -> void:
	var direction := Vector3.ZERO

	# Left/right movement
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1

	# Forward/backward movement (depth)
	if Input.is_action_pressed("ui_up"):
		direction.z -= 1
	if Input.is_action_pressed("ui_down"):
		direction.z += 1

	# Normalize so diagonal isn’t faster
	if direction != Vector3.ZERO:
		direction = direction.normalized()

	# Apply different speeds to axes
	var velocity := Vector3(
		direction.x * speed_side,
		0.0,
		direction.z * speed_depth
	)

	# Move the character
	translate(velocity * delta)

	# Clamp position inside the bounding box
	global_position.x = clamp(global_position.x, min_x, max_x)
	global_position.z = clamp(global_position.z, min_z, max_z)
