extends TileMapLayer

var player_obj: PackedScene = preload("res://Objects/player.tscn")

func _ready() -> void:
	MapGen.generate_roomsPoints(self, 5, 8, 20, false)
	await Globals.mapGenerated
	if Globals.mapGenerated:
		var randPos = Globals.openTiles[randi_range(1, Globals.openTiles.size())]
		print(randPos)
		var player = player_obj.instantiate()
		player.position = randPos*64
		print(player.position)
		add_child(player)
