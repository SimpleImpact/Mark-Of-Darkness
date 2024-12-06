extends Node2D
var hall1: PackedScene = preload("res://Rooms/Halls/hall1.tscn")
var room1: PackedScene = preload("res://Rooms/Rooms/mainRoom1.tscn")
func _ready() -> void:
	var door1 = get_meta("Door1")
	var door2 = get_meta("Door2")
	var door3 = get_meta("Door3")
	#addHall(door1.x, door1.y, door1.z)
	spawnRoom1(-1152, 0, 90)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_exited(_body: Node2D) -> void:
	pass # Replace with function body.

func rand(low, high):
	return(RandomNumberGenerator.new().randi_range(low, high))
	
func spawnHall1(x, y, rot):
	var hall = hall1.instantiate()
	hall.position = Vector2(x, y)
	hall.rotation = deg_to_rad(rot)
	add_child(hall)
			
func spawnRoom1(x, y, rot):
	var room = room1.instantiate()
	room.position = Vector2(x, y)
	room.rotation = deg_to_rad(rot)
	add_child(room)
	spawnHall1(x, y - 1280, 0)
	spawnHall1(x - 1280, y, 90)
	spawnHall1(x, y + 1280, 0)
	
