extends Node2D

var cooldown = true

@onready var sprite = $BowSprite
@onready var arrowScene = preload("res://Attacks/Projectiles/arrow.tscn")

var baseAttackSpeed = 0.5

func _process(_delta: float) -> void:
	if Input.is_action_pressed("M1") and cooldown:
		sprite = $BowSprite
		var arrow = arrowScene.instantiate()
		look_at(get_global_mouse_position())
		sprite.play("Shoot")
		cooldown = false
		arrow.rotation_degrees = rotation_degrees
		arrow.position = global_position
		Globals.projectileContainer.add_child(arrow)
		start_timer()

func start_timer():
	var timer = get_tree().create_timer(baseAttackSpeed) #*modifiers
	timer.timeout.connect(timeout_function)

func timeout_function():
	cooldown = true
