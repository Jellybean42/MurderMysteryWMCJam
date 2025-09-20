# InteractionZone.gd 或 InteractArea.gd
extends Area3D

func _ready() -> void:
	monitoring = true
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		Interaction.set_in_zone(true)

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		Interaction.set_in_zone(false)
