extends Node

var change = Vector2(0, 0)
var speed = 5
var delta: float

var left
var right
var up  
var down

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Movement Initalized")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.d
func _process(_delta: float) -> void:
	delta = _delta
	get_input()
	pass

func get_input():
	pass

	
	
