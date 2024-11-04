extends CharacterBody2D

@onready var _animated_sprite = $Player

<<<<<<< HEAD
=======
var change = Vector2(0, 0)
var speed = 400
var delta: float

var left
var right
var up  
var down
>>>>>>> 38b635fa2fba75895c1c94fa51ebe0f1eeb26ecb

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
	pass
<<<<<<< HEAD
=======
	
	
	
	#getChild().position += change * speed * delta 
	change = Vector2(0, 0)
func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()

func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed
>>>>>>> 38b635fa2fba75895c1c94fa51ebe0f1eeb26ecb
