extends CharacterBody2D

@onready var _animated_sprite = $Player
var dash = true
var MaxDist = 400
var v = Vector2(0, 0)
var friction = 0.2
var dashPower = 8

var speed = 1
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
	pass
	
func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("Down") or Input.is_action_pressed("Left") or Input.is_action_pressed("Up") or Input.is_action_pressed("Right"):
		if v.x < 400 * speed:
			if Input.is_action_pressed("Right"):
				v.x = 400 * speed
		if v.x > -400 * speed:
			if Input.is_action_pressed("Left"):
				v.x = -400 * speed
		if v.y > -400 * speed:
			if Input.is_action_pressed("Up"):
				v.y = -400 * speed
		if v.y < 400 * speed:
			if Input.is_action_pressed("Down"):
				v.y = 400 * speed
				
	v = v / (friction + 1)
	
	if Input.is_action_pressed("Mouse2") and dash:
		v.x *= dashPower
		v.y *= dashPower
		start_timer()
		dash = false
		
	velocity = v
	move_and_slide()

func get_input():
	pass

func start_timer():
	var timer = get_tree().create_timer(1.0)
	timer.timeout.connect(timeout_function)

func timeout_function():
	dash = true
