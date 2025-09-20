extends ColorRect

@export var flash_time: float = 0.5	# Time to reach full white
@export var fade_time: float = 2.0	# Time to fade back to transparent

var tween: Tween

func _ready() -> void:
	color = Color(0, 0, 0, 1)
	await get_tree().create_timer(1.0).timeout
	flash_down() # ensure it starts faded out

func flash_up() -> void:
	if tween and tween.is_running():
		tween.kill()

	tween = create_tween()
	tween.tween_property(self, "color", Color(0, 0, 0, 1), flash_time)

func flash_down() -> void:
	if tween and tween.is_running():
		tween.kill()

	tween = create_tween()
	tween.tween_property(self, "color", Color(0, 0, 0, 0), fade_time)
