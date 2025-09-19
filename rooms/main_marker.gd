extends Marker3D

var player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("playernode")

func _process(delta: float) -> void:
	position.x = player.position.x
