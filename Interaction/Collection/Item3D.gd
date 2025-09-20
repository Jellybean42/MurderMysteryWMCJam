extends Area3D

var collected := false
var player_inside := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)  
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_inside = true

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_inside = false

func start_despawn_timer() -> void:
	await get_tree().create_timer(2.0).timeout
	self.visible = false
