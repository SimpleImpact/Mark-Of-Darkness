extends TileMapLayer

var player_obj: PackedScene = preload("res://Objects/player.tscn")

func _ready() -> void:
	await get_tree().process_frame
	
	MapGen.generate_roomsPoints(self, 5, 8, 20, true, false, "Silly Dude")

	
