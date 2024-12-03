extends Node
var slash: PackedScene = preload("res://Objects/Attacks/slash.tscn")
var target = "slash"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if target == "slash":
		var type = slash.instantiate()
		add_child(type)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
