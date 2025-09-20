extends Area3D

@export var item_id: String = "paper_ball"
@export var icon: Texture2D
var collected := false
var player_inside := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)   # Player 进入物品范围
	body_exited.connect(_on_body_exited)
	# 如果由 PickupTrigger 控制显隐，这里不需要再隐藏

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_inside = true
		set_prompt_visible(true)

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_inside = false
		set_prompt_visible(false)

func _unhandled_input(_e: InputEvent) -> void:
	if not collected \
	and player_inside \
	and Interaction.player_in_zone \
	and Input.is_action_just_pressed("interact"):
		_collect()

func _collect() -> void:
	if collected: return
	var ok :bool = Inventory.add_item(item_id, icon, true)
	if ok:
		collected = true
		queue_free()

func set_prompt_visible(v: bool) -> void:
	if has_node("Label3D"):
		$Label3D.visible = v
