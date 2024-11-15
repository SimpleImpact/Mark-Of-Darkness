extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn("skel", Vector2(0, 0))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func spawn(_enemyPath, pos):
	var enemyScene: PackedScene = preload("res://Enemies/Skeleton.tscn")
	var model = enemyScene.instantiate()
	model.position = pos
	add_child(model)
