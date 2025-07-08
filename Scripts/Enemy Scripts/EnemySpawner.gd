extends Node

# Called when the node enters the scene tree for the first time.

@export var enemyPerRoom = 5
@export var wallClearance = 2



var test = [[preload("res://Enemies/Skeleton.tscn"),3],
	[preload("res://Enemies/babyGolem.tscn"),1]]



func genEnemies(enemyPool) -> void:
	await Globals.mapGenerated == true
	await get_tree().create_timer(0.1).timeout
	
	var rng = MapGen.rng
	var rooms = MapGen.rooms
	
	var weightedPool = []
	for type in enemyPool:
		for i in range(type[1]):
			weightedPool.append(type[0])
	
	for index in range(len(rooms)):
		var newPos = Vector2()
		for i in range(enemyPerRoom):
			var x = rooms[index].rect.position.x
			var y = rooms[index].rect.position.y
			newPos.x = rng.randf_range(x+wallClearance,x+rooms[index].rect.size.x-wallClearance)
			newPos.y = rng.randf_range(y+wallClearance,y+rooms[index].rect.size.y-wallClearance)
			
			spawn(weightedPool[rng.randi_range(0,len(weightedPool)-1)], newPos*64)
		#await get_tree().create_timer(0.1).timeout


func spawn(_enemyPath, pos):
	var enemyScene: PackedScene = _enemyPath
	var model = enemyScene.instantiate()
	model.global_position = pos
	get_parent().add_child(model)
