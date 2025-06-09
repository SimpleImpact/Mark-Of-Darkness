extends Node

@onready var tilemap = $TileMapLayer

var arr:Array
var cords:String
var atlas:Vector2i

func _ready() -> void:
	arr = [["c(4, 4)", "a(0, 0)"], ["c(5, 4)", "a(0, 0)"], ["c(6, 4)", "a(0, 0)"], ["c(7, 4)", "a(0, 0)"], ["c(4, 5)", "a(0, 0)"], ["c(5, 5)", "a(1, 0)"], ["c(6, 5)", "a(1, 0)"], ["c(7, 5)", "a(1, 0)"], ["c(4, 6)", "a(0, 0)"], ["c(5, 6)", "a(1, 0)"], ["c(6, 6)", "a(1, 0)"], ["c(7, 6)", "a(1, 0)"], ["c(4, 7)", "a(0, 0)"], ["c(5, 7)", "a(1, 0)"], ["c(6, 7)", "a(1, 0)"], ["c(7, 7)", "a(1, 0)"]]
	for i in arr:
		for g in i:
			for e in g:
				print(e.replace("c", "").replace(" ", ""))
