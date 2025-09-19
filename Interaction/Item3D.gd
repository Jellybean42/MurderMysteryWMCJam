# Item3D.gd
extends Area3D

@export var item_id: String = "apple"
@export var icon: Texture2D
var collected := false

func collect(by: Node) -> void:
	if collected: return
	var ok := Inventory.add_item(item_id, icon, true) # 是否允许重复：true/false
	if ok:
		collected = true
		queue_free()

# 可选：给玩家显示提示用
func set_prompt_visible(v: bool) -> void:
	if has_node("Label3D"):
		$Label3D.visible = v
