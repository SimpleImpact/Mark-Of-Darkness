extends Node2D
var hall1: PackedScene = preload("res://Rooms/Halls/hall1.tscn")
func _ready() -> void:
	var door1 = get_meta("Door1")
	var door2 = get_meta("Door2")
	var door3 = get_meta("Door3")
	#addHall(door1.x, door1.y, door1.z)
	if (door1.x == 0 and door1.y == 0):
		pass
	else:
		var n = rand(1, 1)
		if n == 1:
			var hall = hall1.instantiate()
			hall.position = Vector2(door1.x, door1.y)
			print(hall.global_rotation)
			hall.global_rotation += deg_to_rad(door1.z)
			print(hall.rotation)
			add_child(hall)
			print("Hall added!")
			print(hall.rotation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_exited(_body: Node2D) -> void:
	pass # Replace with function body.

func rand(low, high):
	return(RandomNumberGenerator.new().randi_range(low, high))
	
func addHall(x, y, rot):
	if (x == 0 and y == 0):
		pass
	else:
		var n = rand(1, 1)
		if n == 1:
			var hall = hall1.instantiate()
			hall.position = Vector2(x, y)
			hall.global_rotation -= rot
			print(hall.rotation)
			add_child(hall)
			print("Hall added!")
