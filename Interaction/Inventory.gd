extends Node

## 全局背包系统
## 把这个脚本在 Project Settings → Autoload 里注册为单例，名字填 `Inventory`

signal inventory_changed(items: Array)

@export var max_slots: int = 8
var items: Array = []   # 每个元素: { "id": String, "icon": Texture2D }

## 添加物品
func add_item(id: String, icon: Texture2D, allow_duplicates: bool = true) -> bool:
	# 背包已满
	if items.size() >= max_slots:
		return false
	
	# 不允许重复，则检查是否已有
	if not allow_duplicates:
		for it in items:
			if it["id"] == id:
				emit_signal("inventory_changed", items)
				return true
	
	# 添加新物品
	items.append({ "id": id, "icon": icon })
	emit_signal("inventory_changed", items)
	return true


## 移除物品（可选）
func remove_item(id: String) -> bool:
	for i in range(items.size()):
		if items[i]["id"] == id:
			items.remove_at(i)
			emit_signal("inventory_changed", items)
			return true
	return false


## 清空背包（可选）
func clear() -> void:
	items.clear()
	emit_signal("inventory_changed", items)
