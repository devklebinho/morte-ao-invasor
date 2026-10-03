extends Node

func _ready():
	MusicManager.play_music(preload("res://Audio/looperman-l-0623169-0433560-pure-souls-synths-part1-nofuk.ogg"))

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/gameplay.tscn")
	
func _on_options_pressed() -> void:
		get_tree().change_scene_to_file("res://Scenes/Options.tscn")

func _on_credits_pressed() -> void:
	#get_tree().change_scene_to_file("res://Scenes/Credits.tscn")
	print("Imagine Credits here! It will be implemented after")
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	get_tree().quit()
