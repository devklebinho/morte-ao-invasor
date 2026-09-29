extends Area2D

# ============================================================
# REFERÊNCIAS
# ============================================================

# Referência ao CameraManager. 
# O caminho $"../../Managers/CameraManager" sobe dois níveis 
# (sai da porta -> sai da sala) e entra em Managers.
@onready var camera_manager = $"../../Managers/CameraManager"


# ============================================================
# VARIÁVEIS EXPORTADAS (Configuradas no Inspetor de cada Porta)
# ============================================================

# Nome da câmera de destino. Ex: "Camera2DCozinha"
@export var target_camera_name: String = "CameraName"

# Nome da sala de destino. Ex: "Cozinha"
# Este nome DEVE ser igual à chave usada no dicionário do CameraManager.
@export var target_room_name: String = "RoomName"


# ============================================================
# LÓGICA DE DETECÇÃO
# ============================================================

func _on_body_entered(body: Node2D) -> void:
	# Verifica se o corpo que entrou é o Player
	if not body.is_in_group("Player"):
		return # Se não for o Player, ignora e sai da função
	
	print("Player entrou na porta. Destino: Sala=", target_room_name, " | Câmera=", target_camera_name)
	
	# Verifica se o CameraManager foi encontrado
	if not camera_manager:
		print("ERRO: CameraManager não encontrado!")
		return
	
	# Envia o pedido completo para o CameraManager:
	# 1. Para qual câmera mudar
	# 2. Para qual sala o player deve ir
	# 3. A referência do Player (para poder teletransportá-lo)
	camera_manager.transition_to_room(target_camera_name, target_room_name, body)
