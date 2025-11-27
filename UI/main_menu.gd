extends Control

@onready var main = $MarginContainer/Main
@onready var settings = $MarginContainer/Settings
@onready var startScroll = $MarginContainer/Main/VBoxContainer/StartScroll
@onready var settingsScroll = $MarginContainer/Main/VBoxContainer/SettingsScroll
@onready var quitScroll = $MarginContainer/Main/VBoxContainer/QuitScroll

#Start the game
func _on_start_button_pressed() -> void:
	startScroll.play()


func _on_settings_button_pressed() -> void:
	settingsScroll.play()
	
func _on_quit_button_pressed() -> void:
	quitScroll.play()

func _on_back_button_pressed() -> void:
	main.visible = true
	settings.visible = false

func _on_settings_scroll_animation_finished() -> void:
	main.visible = false
	settings.visible = true
	settingsScroll.stop()
	settingsScroll.frame = 0

func _on_start_scroll_animation_finished() -> void:
	get_tree().change_scene_to_file("res://startNode.tscn")

func _on_quit_scroll_animation_finished() -> void:
	get_tree().quit()
