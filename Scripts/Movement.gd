<<<<<<< HEAD
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
=======
extends CharacterBody2D

@onready var _animated_sprite = $Player
@export var rotation_speed = 1.5
var rotation_direction = 0

var speed = 400
var target
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Animations Initalized")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if Input.is_action_pressed("Up") and Input.is_action_pressed("Down"):
		_animated_sprite.play("Rouge Idle")
	elif Input.is_action_pressed("Right") and Input.is_action_pressed("Left"):
		_animated_sprite.play("Rouge Idle")
	elif Input.is_action_pressed("Up") and Input.is_action_pressed("Left"):
		_animated_sprite.play("Rouge Run Left")
	elif Input.is_action_pressed("Right") or Input.is_action_pressed("Up"):
		_animated_sprite.play("Rouge Run Right")
	elif Input.is_action_pressed("Left") or Input.is_action_pressed("Down"):
		_animated_sprite.play("Rouge Run Left")
	else:
		_animated_sprite.play("Rouge Idle")
>>>>>>> 38b635fa2fba75895c1c94fa51ebe0f1eeb26ecb
	pass
	
func _physics_process(_delta: float) -> void:
	get_input()
	if Input.is_action_pressed("Mouse"):
		if position.distance_to(target) > 10 and position.distance_to(target) < 0.1:
			velocity = position.direction_to(target) * speed * 10
	move_and_slide()

func get_input():
<<<<<<< HEAD
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
=======
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed * 1
	target = Vector2(0, 0)
	target = get_global_mouse_position()
>>>>>>> 38b635fa2fba75895c1c94fa51ebe0f1eeb26ecb
