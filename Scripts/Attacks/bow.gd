extends AnimatedSprite2D

var cooldown = true

@onready var sprite = $AnimatedSprite2D
@onready var arrowScene = preload("res://Attacks/arrow.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_pressed("Attack") and cooldown:
		var arrow = arrowScene.instantiate()
		arrow.rotation_degrees = rotation_degrees
		Globals.projectileContainer.add_child(arrow)
		print("Bow Attack")
		look_at(get_global_mouse_position())
		sprite.play("fire")
		cooldown = false
		start_timer()

func start_timer():
	var timer = get_tree().create_timer(0.25)
	timer.timeout.connect(timeout_function)

func timeout_function():
	cooldown = true
