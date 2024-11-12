extends Node2D
@onready var collider = get_node("Wall")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(_body: Node2D) -> void:
	collider.get_node("Left").set_deferred("disabled", true)
	get_node("Left Wall").get_node("Wall5").set_deferred("visible", false)
	get_node("Left Wall").get_node("Wall3").set_deferred("visible", false)
	pass # Replace with function body.


func _on_area_2d_body_exited(_body: Node2D) -> void:
	collider.get_node("Left").set_deferred("disabled", false)
	get_node("Left Wall").get_node("Wall5").set_deferred("visible", true)
	get_node("Left Wall").get_node("Wall3").set_deferred("visible", true)
	pass # Replace with function body.
