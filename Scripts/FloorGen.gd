extends Node
var Spawn_room: PackedScene = preload("res://map.tscn")
var player_obj: PackedScene = preload("res://Objects/player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var spawn = Spawn_room.instantiate()
	var player = player_obj.instantiate()
	add_child(spawn)
	#add_child(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
