extends Node

#AQUI COMEÇA O JOGO, TROCAR PARA A CENA INICIAL DEPOIS
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/proto_gameplay.tscn")

func _on_options_pressed() -> void:
	#get_tree().change_scene_to_file("res://Scenes/options.tscn")
	pass
func _on_credits_pressed() -> void:
	#get_tree().change_scene_to_file("res://Scenes/credits.tscn")
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	get_tree().quit()
