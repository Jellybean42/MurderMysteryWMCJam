extends Node

signal inventory_changed(items: Array)

@export var max_slots: int = 8
var items: Array = []   

func add_item(id: String, icon: Texture2D, allow_duplicates: bool = true) -> bool:
	if items.size() >= max_slots:
		return false
	
	if not allow_duplicates:
		for it in items:
			if it["id"] == id:
				emit_signal("inventory_changed", items)
				return true
	
	items.append({ "id": id, "icon": icon })
	emit_signal("inventory_changed", items)
	return true

func remove_item(id: String) -> bool:
	for i in range(items.size()):
		if items[i]["id"] == id:
			items.remove_at(i)
			emit_signal("inventory_changed", items)
			return true
	return false

func clear() -> void:
	items.clear()
	emit_signal("inventory_changed", items)
