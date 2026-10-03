extends Node

func _ready():
	MusicManager.play_music(preload("res://Audio/looperman-l-0623169-0433560-pure-souls-synths-part1-nofuk.ogg"))

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/gameplay.tscn")
	
func _on_options_pressed() -> void:
		get_tree().change_scene_to_file("res://Scenes/Options.tscn")

func _on_credits_pressed() -> void:
	var link_itchio = "https://devklebinho.itch.io/morte-ao-invasor"
	OS.shell_open(link_itchio)
	
func _on_quit_pressed() -> void:
	get_tree().quit()
