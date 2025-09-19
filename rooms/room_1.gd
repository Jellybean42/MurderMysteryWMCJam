extends Node3D

@onready var main_side: CSGBox3D = $MainSide
@onready var other_side: Node3D = $OtherSide

func hide_main():
	main_side.hide()

func show_main():
	main_side.show()

func hide_other():
	other_side.hide()

func show_other():
	other_side.show()
