extends Area3D

@export var item_node: Node3D
@export var one_shot := true

var player_inside := false
var fired := false

func _ready() -> void:
	monitoring = true
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	if item_node:
		item_node.visible = false   # 初始隐藏

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_inside = true

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_inside = false

func _unhandled_input(_event: InputEvent) -> void:
	if fired or not player_inside:
		return
	if Input.is_action_just_pressed("interact"):   # E 键或你映射的按键
		if item_node:
			item_node.visible = true
		fired = true
		if one_shot:
			monitoring = false
