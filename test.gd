extends TileMapLayer

func _ready() -> void:
	MapGen.generate_roomsPoints(self, 5, 8, 20, false)
