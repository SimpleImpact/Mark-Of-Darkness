extends Node2D

var cooldown = true
var slashObject: PackedScene = preload("res://Objects/Attacks/slash.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	slash()
	pass


	
func slash():
	var slash = slashObject.instantiate()
