extends Node

@onready var tilemap = $TileMapLayer

var arr:Array
var cord:Vector2i
var room:Array
var fileName = "Circle"
var file = FileAccess.open("res://Rooms/" + fileName + ".json", FileAccess.READ)
var roomData = str_to_var(file.get_file_as_string("res://Rooms/" + fileName + ".json"))


func _ready() -> void:
	arr = roomData.get("_Data")
	for i in arr:
		for g in i:
			for e in g:
				if e == "c":
					cord = strToVector(g)
					break
				if e == "a":
					room.append([cord, strToVector(g)])
					break
	for i in room:
		tilemap.set_cell(i[0], 0, i[1])
		
func strToVector(string):
	var raw = (string.erase(0).erase(4).split(", "))
	return(Vector2i(int(raw[0]), int(raw[1])))
