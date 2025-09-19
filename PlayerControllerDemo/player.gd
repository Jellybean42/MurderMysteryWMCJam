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
# player.gd（只展示新增/修改部分）
extends CharacterBody3D

@onready var interact_area: Area3D = $InteractArea
var target: Node = null

func _ready() -> void:
	# 连接进入/离开事件
	interact_area.body_entered.connect(_on_body_entered)
	interact_area.body_exited.connect(_on_body_exited)
	# 如果你用的是 area_entered/area_exited，请把类型和回调对应改为 Area3D

func _on_body_entered(body: Node) -> void:
	if body.has_method("collect"): # 只认会被“收集”的对象
		target = body
		_show_prompt(true, body)

func _on_body_exited(body: Node) -> void:
	if body == target:
		_show_prompt(false, body)
		target = null

func _unhandled_input(event: InputEvent) -> void:
	if target and Input.is_action_just_pressed("interact"):
		# 调用物品的 collect（玩家主导交互）
		if target.has_method("collect"):
			target.collect(self)  # 传入自己可选
			target = null

func _show_prompt(show: bool, body: Node) -> void:
	# 可选：让物品自己显示/隐藏“按E拾取”的提示
	if body.has_method("set_prompt_visible"):
		body.set_prompt_visible(show)
