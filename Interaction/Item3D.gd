extends Area3D

@export var item_id: String = "apple"
@export var icon: Texture2D
var collected := false

func collect(_by: Node) -> void:  # 参数未使用前面加下划线可消警告
	if collected: return
	var ok := Inventory.add_item(item_id, icon, true)
	if ok:
		collected = true
		queue_free()

func set_prompt_visible(v: bool) -> void:
	if has_node("Label3D"):
		$Label3D.visible = v
