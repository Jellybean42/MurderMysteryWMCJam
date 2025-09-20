extends Area3D

var player_inside := false
var collected := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player") and not collected:
		player_inside = true

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_inside = false

func _unhandled_input(_event: InputEvent) -> void:
	if collected and not player_inside:
		print("retyur")
	else:
		print("gone")
		if Input.is_action_just_pressed("interact"):   # E 键
			await get_tree().create_timer(2.0).timeout
			queue_free()  
