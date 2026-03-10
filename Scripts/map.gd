extends TileMapLayer

var player_obj: PackedScene = preload("res://Objects/player.tscn")

@export var roomNum = 5
@export var minSize = 8
@export var maxSize = 20

func _ready() -> void:
	Globals.projectileContainer = $"Projectile Container"
	await get_tree().process_frame
	MapGen.generate_roomsPoints(self, roomNum, minSize, maxSize, false, false, "Silly Dude")
	var default_map_rid: RID = get_world_2d().get_navigation_map()
	var navRegion = NavigationServer2D.get_maps()
	print(default_map_rid)
	print(NavigationServer2D.map_get_cell_size(navRegion[0]))
