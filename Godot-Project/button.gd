extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CobbleMap.gen(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	print("New Map")
	CobbleMap.gen(1)
