extends Control

@onready var card = $Card
@onready var cardTexture = $Texture
@onready var targetPos = Vector2(cardTexture.position.x, cardTexture.position.y)
var tweenPos : Tween
var tweenRot : Tween
var tweenScale : Tween

func _on_card_mouse_entered() -> void:
	moveIn()

func _on_card_mouse_exited() -> void:
	moveOut()

func moveIn():
	tweenPos = create_tween()
	tweenRot = create_tween()
	tweenScale = create_tween()
	cardTexture.z_index = 1000
	tweenPos.tween_property(cardTexture, "position", Vector2(cardTexture.position.x -10, -100), 0.2)
	tweenRot.tween_property(cardTexture, "rotation", -0.174533, 0.2)
	tweenScale.tween_property(cardTexture, "scale", Vector2(1.3, 1.3), 0.2)

func moveOut():
	tweenPos = create_tween()
	tweenRot = create_tween()
	tweenScale = create_tween()
	cardTexture.z_index = 0
	tweenPos.tween_property(cardTexture, "position", Vector2(targetPos.x, 0), 0.2)
	tweenRot.tween_property(cardTexture, "rotation", 0, 0.2)
	tweenScale.tween_property(cardTexture, "scale", Vector2(1.1, 1.1), 0.2)

func fadeOut():
	var alpha = 1
	for i in 20:
		cardTexture.modulate = Color(0, 0, 0, alpha - (i *5))

func _on_card_pressed() -> void:
	fadeOut()
