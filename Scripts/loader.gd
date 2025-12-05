extends Node
#1. map
#2. player
#3. enemies

var dungeon = preload("res://map.tscn")
var dungeonScene = dungeon.instantiate()
var player_obj: PackedScene = preload("res://Objects/player.tscn")

func _ready() -> void:
	Globals.mapGen.connect(mapGenerated)
	Globals.playerSpawned.connect(playerSpawned)
	add_child(dungeonScene)

func mapGenerated():
	playerSpawn()
	
func playerSpawn():
	var randomTile = Globals.openTiles[randi_range(1, Globals.openTiles.size())]
	var player = player_obj.instantiate()
	player.position = randomTile*64
	Globals.spawnReady = false
	add_child(player)

func playerSpawned():
	EnemySpawner.genEnemies(EnemySpawner.test)
