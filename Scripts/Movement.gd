extends Node

var change = Vector2(0, 0)
var pos = self.position
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
	left = Input.is_action_pressed("Left")
	right = Input.is_action_pressed("Right")
	up  = Input.is_action_pressed("Up")
	down = Input.is_action_pressed("Down")
	
	if right: change.x += 50
	if left: change.x -= 50
	if up: change.y -= 50
	if down: change.y += 50
	
	self.position += change * speed * delta 
	change = Vector2(0, 0)
