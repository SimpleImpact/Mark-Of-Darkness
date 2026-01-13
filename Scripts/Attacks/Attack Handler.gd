extends Node

var attackName = "bow"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var attack = load("res://Attacks/bow.tscn")
	var type = attack.instantiate()
	add_child(type)
