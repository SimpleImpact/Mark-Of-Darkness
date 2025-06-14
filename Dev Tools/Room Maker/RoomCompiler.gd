extends Node2D

@onready var tilemap = $TileMapLayer
var room:Array
###  Tile Cords           Atlas Cords
#               \        /
### Outputs [[c(1, 0), a(0, 0)], [(2, 0), (0, 1)], ...]

func _ready() -> void:
	for r in 8:
		for e in 8:
			var index = tilemap.get_cell_atlas_coords(Vector2i(e-4, r-4))
			if index != Vector2i(-1, -1):
				room.append(["c" + str(e) + ", " + str(r) +")", "a" + str(index.x) + ", " + str(index.y) +")",])
	print(room)

	
func printThis(x):
	print(x)
