extends Node
signal inventory_changed(items: Array)

@export var max_slots: int = 8
var items: Array = []  # 每个元素: {"id": String, "icon": Texture2D}

func add_item(id: String, icon: Texture2D, allow_duplicates := true) -> bool:
	if items.size() >= max_slots:
		return false
	if not allow_duplicates:
		for it in items:
			if it.id == id:
				emit_signal("inventory_changed", items)
				return true
	items.append({ "id": id, "icon": icon })
	emit_signal("inventory_changed", items)
	return true
