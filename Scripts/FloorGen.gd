extends Node
var Spawn_room: PackedScene = preload("res://map.tscn")
var player_obj: PackedScene = preload("res://Objects/player.tscn")
var ui_obj: PackedScene = preload("res://UI/control.tscn")
@export var debug = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var spawn = Spawn_room.instantiate()
	var player = player_obj.instantiate()
	var ui = ui_obj.instantiate()
	add_child(spawn)
	#add_child(player)
	EnemySpawner.genEnemies(EnemySpawner.test)
	if debug:
		$"Layer 1 Light".enabled = false
		$"Player Camera".zoom = Vector2(0.25, 0.25)
	else:
		$"Player Camera".zoom = Globals.CamZoom

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	Globals.debug = debug
	Globals.CamPos = Globals.playerPos
	$"Player Camera".position = Globals.CamPos
	pass
