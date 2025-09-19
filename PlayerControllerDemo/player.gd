extends Node3D

@export var speed_side: float = 5.0   # fast
@export var speed_depth: float = 2.0  # slow

# Bounds in world space
@export var min_x: float = -5.0
@export var max_x: float =  5.0
@export var min_z: float = -3.0
@export var max_z: float =  3.0

var facing_angle := 0.0  # Track rotation in degrees

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

	# Rotate player + camera together
	if Input.is_action_just_pressed("ui_select"):
		facing_angle += 90.0
		rotation_degrees.y = facing_angle

# Collection Interaction
@onready var interact_area: Area3D = get_node_or_null("InteractArea")
var target: Node = null

func _ready() -> void:
	if interact_area:
		# 注意：Area3D ↔ Area3D 用 area_entered / area_exited
		interact_area.area_entered.connect(_on_area_entered)
		interact_area.area_exited.connect(_on_area_exited)
	else:
		push_error("InteractArea not found under Player. Please add an Area3D named 'InteractArea'.")

func _on_area_entered(area: Area3D) -> void:
	if area and area.has_method("collect"):
		target = area
		_show_prompt(true, area)

func _on_area_exited(area: Area3D) -> void:
	if area == target:
		_show_prompt(false, area)
		target = null

func _unhandled_input(event: InputEvent) -> void:
	if target and Input.is_action_just_pressed("interact"):
		if target.has_method("collect"):
			target.collect(self)
		target = null

func _show_prompt(v: bool, node: Node) -> void:
	if node and node.has_method("set_prompt_visible"):
		node.set_prompt_visible(v)
