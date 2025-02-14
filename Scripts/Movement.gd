extends CharacterBody2D

@onready var _animated_sprite = $"Player Sprite"
@onready var camera = $'Player Camera'
@onready var collider = $'Player Collider'
var dash = true

@export var maxSpeed = 500

#time to reach max speed 
@export var accel = 0.5
#Time to go back from max to zero
@export var decel = 0.25
#How smooth and round to make turns
@export var turnWeight = 5

var curSpeed = 0
var lastVelo = Vector2(0,0)
func _ready() -> void:
	print("Movement Initalized")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if Input.is_action_pressed("Down") and Input.is_action_pressed("Left") and Input.is_action_pressed("Up") and Input.is_action_pressed("Right"):
		_animated_sprite.play("Rouge Idle")
	elif Input.is_action_pressed("Up") and Input.is_action_pressed("Down"):
		if Input.is_action_pressed("Right"):
			_animated_sprite.play("Rouge Run Right")
		elif Input.is_action_pressed("Left"):
			_animated_sprite.play("Rouge Run Left")
		else:
			_animated_sprite.play("Rouge Idle")
	elif Input.is_action_pressed("Left") and Input.is_action_pressed("Right"):
		if Input.is_action_pressed("Down"):
			_animated_sprite.play("Rouge Run Left")
		elif Input.is_action_pressed("Up"):
			_animated_sprite.play("Rouge Run Right")
		else:
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
	pass
	
	camera.make_current()
	
	if Input.is_action_just_released("C"):
		if collider.is_disabled():
			collider.disabled = false
			$Lamp.enabled = true
			$DirectionalLight2D.enabled = true
		else:
			collider.disabled = true
			$DirectionalLight2D.enabled = false
			$Lamp.enabled = false

#Func for input directions
func get_input():
	var input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	if input_dir:
		#Smooth the direction change out by avg last direction with input and use turnWeight
		lastVelo = ((lastVelo*turnWeight)+input_dir)/(turnWeight+1)
	return input_dir

#Move func
func _physics_process(delta):
	var input_dir = get_input()
	
	#Increase current speed when given input
	if lastVelo and input_dir and curSpeed<maxSpeed:
		curSpeed += maxSpeed*delta/accel
	#If no input decrease speed
	elif curSpeed>0:
		curSpeed -= maxSpeed*delta/decel
	
	#Reset last velocity if not moving or input
	if curSpeed == 0 and not input_dir:
		lastVelo = Vector2(0,0)
	
	#Ensures speed doesnt go above max or below zero
	if curSpeed<0:
		curSpeed = 0
	elif curSpeed>maxSpeed:
		curSpeed = maxSpeed
	
	Globals.playerPos = position
	#Apply input and speed to velocity and move
	velocity = lastVelo*curSpeed
	move_and_slide()
	if Input.is_action_pressed("Mouse2") and dash:
		#v.x *= dashCof
		#v.y *= dashCof
		#start_timer()
		#dash = false
		position = get_global_mouse_position()
		



func start_timer():
	var timer = get_tree().create_timer(1.0)
	timer.timeout.connect(timeout_function)

func timeout_function():
	dash = true


func _on_button_pressed() -> void:
	pass # Replace with function body.
