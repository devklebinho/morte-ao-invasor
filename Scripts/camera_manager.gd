extends Node

# ============================================================
# REFERÊNCIAS A NÓS
# ============================================================

# A câmera que faz a transição visual suave entre as salas.
@onready var transition_camera: Camera2D = $"../../Cameras/TransitionCamera2D"


# ============================================================
# DICIONÁRIOS DE CONFIGURAÇÃO
# ============================================================

# Mapeia NOME da câmera -> NÓ da câmera.
# Use "Arrastar e Soltar" para preencher os caminhos corretamente.
@onready var cameras = {
	"Camera2DSala": $"../../Cameras/Camera2DSala",
	"Camera2DCozinha": $"../../Cameras/Camera2DCozinha"
}

# Mapeia NOME da sala -> NÓ do ponto de spawn (Marker2D).
# IMPORTANTE: As chaves daqui devem ser iguais às do "target_room_name" das portas!
@onready var spawn_points = {
	"SalaL": $"../../Sala/LRoomSP",           # Caminho: sobe 1 nível (..), entra em Sala, pega LRoomSP
	"CozinhaR": $"../../Cozinha/RKitchenSP", # Caminho: sobe 1 nível (..), entra em Cozinha, pega RKitchenSP
	"CozinhaL": $"../../Cozinha/LKitchenSP" # Caminho: sobe 1 nível (..), entra em Cozinha, pega LKitchenSP
}


# ============================================================
# VARIÁVEIS DE ESTADO
# ============================================================

# Guarda qual câmera está ativa no momento.
var selected_camera: Camera2D = null

# Guarda a animação (Tween) atual, para podermos cancelá-la se necessário.
var transition_tween: Tween


# ============================================================
# INICIALIZAÇÃO
# ============================================================

func _ready():
	# Define a câmera inicial do jogo (Sala).
	selected_camera = cameras["Camera2DSala"]
	
	# Ativa a câmera de transição como a câmera principal.
	transition_camera.make_current()
	
	# Sincroniza a câmera de transição com a câmera inicial.
	transition_camera.global_position = selected_camera.global_position
	transition_camera.zoom = selected_camera.zoom


# ============================================================
# FUNÇÃO PRINCIPAL (Chamada pelas Portas)
# ============================================================

# Esta é a função "pública" que as portas chamam.
# Ela faz tudo: troca a câmera E teletransporta o Player.
func transition_to_room(camera_name: String, room_name: String, player: Node2D) -> void:
	# --- PARTE 1: Trocar a Câmera ---
	if not cameras.has(camera_name):
		print("ERRO: Câmera não encontrada: ", camera_name)
		return
	
	var desired_camera: Camera2D = cameras[camera_name]
	_change_camera(desired_camera)
	
	# --- PARTE 2: Teletransportar o Player ---
	if not spawn_points.has(room_name):
		print("ERRO: Spawn point não encontrado para a sala: ", room_name)
		return
	
	var spawn_point: Node2D = spawn_points[room_name]
	player.global_position = spawn_point.global_position
	print("Player teletransportado para: ", room_name)


# ============================================================
# FUNÇÃO INTERNA (Executa o Tween da Câmera)
# ============================================================

func _change_camera(desired_camera: Camera2D) -> void:
	# Se já estamos nessa câmera, não faz nada.
	if selected_camera == desired_camera:
		return
	
	# Cancela o Tween anterior, se estiver rodando.
	if transition_tween:
		transition_tween.kill()
	
	# Cria um novo Tween paralelo (anima posição E zoom ao mesmo tempo).
	transition_tween = create_tween().set_parallel(true)
	
	# Anima a posição da câmera de transição até a câmera desejada.
	transition_tween.tween_property(
		transition_camera, 
		"global_position", 
		desired_camera.global_position, 
		0.5
	).set_trans(Tween.TRANS_SINE)
	
	# Anima o zoom da câmera de transição até a câmera desejada.
	transition_tween.tween_property(
		transition_camera, 
		"zoom", 
		desired_camera.zoom, 
		0.5
	).set_trans(Tween.TRANS_SINE)
	
	# Atualiza a câmera ativa.
	selected_camera = desired_camera
