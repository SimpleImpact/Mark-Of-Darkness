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
	tweenScale = create_tween()
	cardTexture.z_index = 1000
	tweenScale.tween_property(cardTexture, "scale", Vector2(1.15, 1.15), 0.2)

func moveOut():
	tweenScale = create_tween()
	cardTexture.z_index = 0
	tweenScale.tween_property(cardTexture, "scale", Vector2(1.1, 1.1), 0.2)

func fadeOut():
	var alpha = 1
	for i in 20:
		cardTexture.modulate = Color(0, 0, 0, alpha - (i *5))

func _on_card_pressed() -> void:
	fadeOut()
