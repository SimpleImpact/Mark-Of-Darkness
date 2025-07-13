extends Control

@onready var main = $MarginContainer/Main
@onready var settings = $MarginContainer/Settings

#Start the game
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://node_2d.tscn")


func _on_settings_button_pressed() -> void:
	main.visible = false
	settings.visible = true


func _on_back_button_pressed() -> void:
	main.visible = true
	settings.visible = false


func _on_quit_button_pressed() -> void:
	get_tree().quit()
