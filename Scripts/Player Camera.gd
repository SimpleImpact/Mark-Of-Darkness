extends Camera2D

var UI : PackedScene = preload("res://UI/control.tscn")
func _ready() -> void:
	var ui = UI.instantiate()
	add_child(ui)
