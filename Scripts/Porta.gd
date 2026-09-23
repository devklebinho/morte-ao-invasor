extends Area2D

@export var pos_destino_player: Marker2D
@export var pos_destino_cam: Marker2D
@export var tempo_trans: float = 0.5

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var camera: Camera2D = get_tree().get_first_node_in_group("CameraGlobal")

func _ready():
	# Conecta o sinal automaticamente ao iniciar
	if player:
		print("Player encontrado: ", player.name)
	else:
		push_error("ERRO: Nenhum nó no grupo 'Player' foi encontrado!")

	if camera:
		print("Câmera encontrada: ", camera.name)
	else:
		push_error("ERRO: Nenhuma câmera no grupo 'CameraGlobal' foi encontrada!")

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	else:
		print("O player entrou na área!")
		print("Quem entrou foi: ", body.name)
	pass # Replace with function body.
