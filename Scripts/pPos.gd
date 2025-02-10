extends AnimatedSprite2D
@onready var playerPos = get_parent().position


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	playerPos = get_parent().position
