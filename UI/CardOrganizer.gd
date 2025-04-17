extends HBoxContainer

@export var card_scene: PackedScene = preload("res://blankCard.tscn") # Assuming you have a Card scene
@export var card_count: int = 100
@export var overlap_amount: int = 20  # Amount of overlap in pixels

func _ready():
	for i in range(card_count):
		var card = card_scene.instantiate()
		add_child(card)

		# Set the z_index for stacking
		card.z_index = 1

		# Calculate the position for overlap
		var offset = Vector2(i , 0) # Adjust for horizontal
		card.position = offset

		# Set size flags to expand
		card.size_flags_horizontal = Control.SIZE_EXPAND_FILL
