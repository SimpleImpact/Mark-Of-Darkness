extends AnimatedSprite2D

var cooldown = true
@onready var collider = get_child(0).get_child(0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(get_child(0).get_child(0))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("Attack") and cooldown:
		collider.disabled = false
		look_at(get_global_mouse_position())
		rotation_degrees += 90
		play("Slash")
		cooldown = false
		start_timer()
	elif frame == 8:
		collider.disabled = true

func start_timer():
	var timer = get_tree().create_timer(0.25)
	timer.timeout.connect(timeout_function)

func timeout_function():
	cooldown = true
