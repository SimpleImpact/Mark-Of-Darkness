extends TileMapLayer

var player_obj: PackedScene = preload("res://Objects/player.tscn")

@export var roomNum = 5
@export var minSize = 8
@export var maxSize = 20

func _ready() -> void:
	await get_tree().process_frame
	
	MapGen.generate_roomsPoints(self, roomNum, minSize, maxSize, true, false, "Silly Dude")

	
