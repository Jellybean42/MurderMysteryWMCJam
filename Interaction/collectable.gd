extends Area3D

@export var object_tex : Texture
@export var letter_tex : Texture

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
		letter.show()
		Global.find_letter(letter_key)
		await get_tree().create_timer(1.0).timeout
		letter.hide()
