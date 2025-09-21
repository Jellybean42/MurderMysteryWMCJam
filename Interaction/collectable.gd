extends Area3D

@export var object_tex : Texture
@export var letter_tex : Texture
@export var letter_var : String

@onready var object: Sprite3D = $Object
@onready var letter: Sprite3D = $Letter

@export var letter_key: String

var valid : bool = false

func _ready() -> void:
	object.texture = object_tex
	letter.texture = letter_tex


func _on_body_entered(body: Node3D) -> void:
	valid = true


func _on_body_exited(body: Node3D) -> void:
	valid = false


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and valid:
		get_tree().get_first_node_in_group("player").collect()
		letter.show()
		Global.find_letter(letter_var)
		await get_tree().create_timer(2.0).timeout
		Global.find_letter(letter_key)
		letter.hide()
