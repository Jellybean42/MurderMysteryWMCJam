extends Node
signal zone_changed(in_zone: bool)
var player_in_zone := false

func set_in_zone(v: bool) -> void:
	if player_in_zone == v: return
	player_in_zone = v
	zone_changed.emit(v)
