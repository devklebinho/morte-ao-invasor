extends Area2D

# Referência ao CameraManager. 
# O caminho absoluto funciona, mas o ideal é arrastar o nó da cena para cá.
@onready var camera_manager = $"../../Managers/CameraManager"

# Qual câmera esta porta deve ativar? 
# Mude isso no Inspetor para cada porta que você criar.
@export var target_camera_name: String = "TemplateName" 

func _on_body_entered(body: Node2D) -> void:
	# Verifica se o corpo que entrou é o Player
	if body.is_in_group("Player"):
		print("O player entrou na área da porta. Solicitando troca para: ", target_camera_name)
		
		# Verifica se o CameraManager foi encontrado para evitar erros
		if camera_manager:
			camera_manager.change_camera(target_camera_name)
		else:
			print("ERRO: CameraManager não encontrado!")
