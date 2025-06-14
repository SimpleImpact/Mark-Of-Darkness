extends Node

@onready var tilemap = $TileMapLayer

var arr:Array
var cords:Array
var atlas:Array

func _ready() -> void:
	arr = [["c4, 4)", "a0, 0)"], ["c5, 4)", "a0, 0)"], ["c6, 4)", "a0, 0)"], ["c7, 4)", "a0, 0)"], ["c4, 5)", "a0, 0)"], ["c5, 5)", "a1, 0)"], ["c6, 5)", "a1, 0)"], ["c7, 5)", "a1, 0)"], ["c4, 6)", "a0, 0)"], ["c5, 6)", "a1, 0)"], ["c6, 6)", "a1, 0)"], ["c7, 6)", "a1, 0)"], ["c4, 7)", "a0, 0)"], ["c5, 7)", "a1, 0)"], ["c6, 7)", "a1, 0)"], ["c7, 7)", "a1, 0)"]]
	for i in arr:
		for g in i:
			for e in g:
				if e == "c":
					cords.append(strToVector(g))
					break
				if e == "a":
					atlas.append(strToVector(g))
					break
	print(cords)
	print(atlas)
func strToVector(s):
	var raw = (s.erase(0).erase(4).split(", "))
	return(Vector2i(int(raw[0]), int(raw[1])))
