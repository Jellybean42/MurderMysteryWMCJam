extends Area3D
@export var item_node: Node3D   # 在 Inspector 里指向场景里的 Item3D
@export var one_shot := true

func _ready() -> void:
	monitoring = true
	body_entered.connect(_on_body_entered)
	if item_node:
		item_node.visible = false   # 初始隐藏

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player") and item_node:
		item_node.visible = true
		if one_shot:
			monitoring = false
