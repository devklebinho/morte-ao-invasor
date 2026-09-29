extends Area2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var camera: Camera2D = get_tree().get_first_node_in_group("CameraGlobal")

func _ready():
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("O papai chegou")
	pass # Replace with function body.
