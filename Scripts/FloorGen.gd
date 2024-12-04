extends Node
var Spawn_room: PackedScene = preload("res://Rooms/Spawn Rooms/spawn_room_1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var spawn = Spawn_room.instantiate()
	add_child(spawn)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
