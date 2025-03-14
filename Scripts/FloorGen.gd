extends Node
var Spawn_room: PackedScene = preload("res://Dungeon.tscn")
var player_obj: PackedScene = preload("res://Objects/player.tscn")
@export var debug = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var spawn = Spawn_room.instantiate()
	var player = player_obj.instantiate()
	add_child(spawn)
	#add_child(player)
	if debug:
		$"Layer 1 Light".enabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	Globals.debug = debug
	pass
