extends TileMapLayer

var player_obj: PackedScene = preload("res://Objects/player.tscn")

func _ready() -> void:
	await get_tree().process_frame
	
	MapGen.generate_roomsPoints(self, 5, 8, 20, true, false, "Silly Dude")
	
	spawnPlayer()
func spawnPlayer():
	if Globals.mapGenerated:
		var randomTile = Globals.openTiles[randi_range(1, Globals.openTiles.size())]
		var player = player_obj.instantiate()
		player.position = randomTile*64
		add_child(player)
	else:
		spawnPlayer()
	
