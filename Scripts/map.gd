extends TileMapLayer

var player_obj: PackedScene = preload("res://Objects/player.tscn")

func _ready() -> void:
	await get_tree().process_frame
	var randomRoomNumber = randi_range(1, Globals.openTiles.size())
	
	MapGen.generate_roomsPoints(self, 5, 8, 20, false, false, "Circle")
	await Globals.mapGenerated
	if Globals.mapGenerated:
		var randRoom = Globals.openTiles[randomRoomNumber]
		var randPos = randRoom[randi_range(1, Globals.openTiles[randomRoomNumber].size())]
		print(randPos)
		var player = player_obj.instantiate()
		player.position = randPos*64
		print(player.position)
		add_child(player)
	pass
