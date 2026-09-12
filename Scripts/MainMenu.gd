extends Node

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/proto_gameplay.tscn")
	
func _on_options_pressed() -> void:
		get_tree().change_scene_to_file("res://Scenes/Options.tscn")

func _on_credits_pressed() -> void:
	#get_tree().change_scene_to_file("res://Scenes/Options.tscn")
	print("Imagine Credits here! It will be implemented after")
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	get_tree().quit()
