extends CharacterBody3D

@export var speed_side: float = 5.0   # fast
@export var speed_depth: float = 2.0  # slow

# Bounds in world space
@export var min_x: float = -5.0
@export var max_x: float =  5.0
@export var min_z: float = -3.0
@export var max_z: float =  3.0

var facing_angle: float = 0.0  # Track rotation in degrees

func _physics_process(delta: float) -> void:
	var local_velocity := Vector3.ZERO

	# Handle input
	if Input.is_action_pressed("ui_left"):
		local_velocity.x -= speed_side
	if Input.is_action_pressed("ui_right"):
		local_velocity.x += speed_side
	if Input.is_action_pressed("ui_up"):
		local_velocity.z -= speed_depth
	if Input.is_action_pressed("ui_down"):
		local_velocity.z += speed_depth

	# Rotate player + camera together
	if Input.is_action_just_pressed("ui_select"):
		facing_angle += 90.0
		rotation_degrees.y = facing_angle

	# Move the character
	if local_velocity != Vector3.ZERO:
		# Convert local velocity into world velocity using the current facing direction
		var world_velocity := global_transform.basis * local_velocity
		velocity = world_velocity
	else:
		velocity = Vector3.ZERO

	move_and_slide()

	# Clamp position to defined bounds
	global_position.x = clamp(global_position.x, min_x, max_x)
	global_position.z = clamp(global_position.z, min_z, max_z)

	# Rotate player + camera together
	if Input.is_action_just_pressed("ui_select"):
		facing_angle += 90.0
		rotation_degrees.y = facing_angle

	if local_velocity != Vector3.ZERO:
		var world_velocity := global_transform.basis * local_velocity
		global_position += world_velocity * delta
		#print_debug("moving to: ", global_position)  # ← 应该能看到输出


# Collection Interaction
func _ready() -> void:
	add_to_group("player")   # 确保玩家在 'player' 组（也可在编辑器里加）
	if Global.player_transform:
		global_transform = Global.player_transform
