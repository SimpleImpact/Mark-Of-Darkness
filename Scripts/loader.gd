extends Node2D
#1. map
#2. player
#3. enemies

var dungeon = preload("res://map.tscn")
var dungeonScene = dungeon.instantiate()
var player_obj: PackedScene = preload("res://Objects/player.tscn")

func _ready() -> void:
	Globals._mapGen.connect(mapGenerated)
	Globals._playerSpawned.connect(playerSpawned)
	add_child(dungeonScene)

func mapGenerated():
	var default_map_rid: RID = get_world_2d().get_navigation_map()
	var navRegion = NavigationServer2D.get_maps()
	#print(default_map_rid)
	#print(NavigationServer2D.map_get_regions(navRegion[0]))
	playerSpawn()
	
func playerSpawn():
	var randomTile = Globals.openTiles[randi_range(1, Globals.openTiles.size())]
	var player = player_obj.instantiate()
	player.position = randomTile*64
	Globals.spawnReady = false
	add_child(player)

func playerSpawned():
	EnemySpawner.genEnemies(EnemySpawner.test)
