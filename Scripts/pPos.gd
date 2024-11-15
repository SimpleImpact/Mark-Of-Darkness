extends AnimatedSprite2D
@onready var playerPos = get_parent().position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var playerPos = get_parent().position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var playerPos = get_parent().position
