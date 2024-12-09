extends Node2D
var hall1: PackedScene = preload("res://Rooms/Halls/hall1.tscn") # striaght
var hall2: PackedScene = preload("res://Rooms/Halls/hall2.tscn") # right turn
var hall3: PackedScene = preload("res://Rooms/Halls/hall3.tscn") # left turn
var room1: PackedScene = preload("res://Rooms/Rooms/room1.tscn") # large room
var room2: PackedScene = preload("res://Rooms/Rooms/room2.tscn") # regular room
var n = 1
var used = []
func _ready() -> void:
	var door1 = get_meta("Door1")
	var door2 = get_meta("Door2")
	var door3 = get_meta("Door3")
	#addHall(door1.x, door1.y, door1.z)
	spawnRoom1(-1280, 0, 0)


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
	n += 1
	if rot == 0: spawnRoom1(x, y - 1280, 0)
	elif rot == -90: spawnRoom1(x - 1280, y, 0)
	elif rot == 180 : spawnRoom1(x, y + 1280, 0)
	elif rot == 90: spawnRoom1(x + 1280, y, 0)
	#spawnRoom1(x, y, rot)
	
func spawnHall2(x, y, rot):
	var hall = hall2.instantiate()
	hall.position = Vector2(x, y)
	hall.rotation = deg_to_rad(rot)
	add_child(hall)
	n += 1
	if rot == 0: spawnRoom1(x + 1280, y, rot)
	elif rot == -90: spawnRoom1(x, y - 1280, rot)
	elif rot == 180 : spawnRoom1(x - 1280, y, rot)
	elif rot == 90: spawnRoom1(x, y + 1280, rot)
	#spawnRoom1(x, y, rot)

func spawnHall3(x, y, rot):
	var hall = hall3.instantiate()
	hall.position = Vector2(x, y)
	hall.rotation = deg_to_rad(rot)
	add_child(hall)
	n += 1
	if rot == 0: spawnRoom1(x - 1280, y, rot)
	elif rot == 90: spawnRoom1(x, y - 1280, rot)
	elif rot == 180 : spawnRoom1(x + 1280, y, rot)
	elif rot == -90: spawnRoom1(x, y + 1280, rot)
	#spawnRoom1(x, y, rot)
			
func spawnRoom1(x, y, rot):
	if n < 100:
		var room = room1.instantiate()
		room.position = Vector2(x, y)
		room.rotation = deg_to_rad(rot)
		add_child(room)
		Callable(self, "spawnHall" + str(rand(1, 3))).call(x, y - 1280, rot + 0)
		Callable(self, "spawnHall" + str(rand(1, 3))).call(x - 1280, y, rot + -90)
		Callable(self, "spawnHall" + str(rand(1, 3))).call(x, y + 1280, rot + 180)
		used.append(Vector2(x, y))
		used.append(Vector2(x, y - 1280))
		used.append(Vector2(x - 1280, y))
		used.append(Vector2(x, y + 1280))
		
		print(used)
	n += 1
	print(n)
	
func check(x, y):
	pass
	
