extends CollisionObject3D  # works for both StaticBody3D and Area3D

@export_file("*.tscn") var target_scene_path: String

@onready var time_travel_flash: ColorRect = $"../CanvasLayer/time_travel_flash"

func _input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_on_clicked()

func _on_clicked():
	print("Painting clicked!")  # debug
	time_travel_flash.flash_up()
	var player = get_tree().get_first_node_in_group("player")
	if player:
		Global.player_transform = player.global_transform

	if target_scene_path != "":
		var target_scene: PackedScene = ResourceLoader.load(target_scene_path)
		if target_scene:
			get_tree().change_scene_to_packed(target_scene)
		else:
			push_warning("Could not load scene at %s" % target_scene_path)
	else:
		push_warning("No target scene path set on %s" % name)
