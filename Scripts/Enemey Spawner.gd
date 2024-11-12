extends Node
var skelModel: PackedScene = preload("res://Enemies/Skeleton.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var skeleton = skelModel.instantiate()
	add_child(skeleton)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
