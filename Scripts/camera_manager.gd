extends Node

# Referência à câmera que faz a transição visual
@onready var transition_camera: Camera2D = $"../../Cameras/TransitionCamera2D"

# Dicionário que mapeia o NOME da câmera para o NÓ real dela.
# Se você criar mais salas (ex: Banheiro), adicione aqui.
@onready var cameras = {
	"Camera2DSala": $"../../Cameras/Camera2DSala",
	"Camera2DCozinha": $"../../Cameras/Camera2DCozinha"
}

# Variável que guarda qual é a câmera ativa no momento
var selected_camera: Camera2D = null

# Variável para armazenar o Tween (animação) atual
var transition_tween: Tween

func _ready():
	# Define a câmera inicial como a da Sala
	selected_camera = cameras["Camera2DSala"]
	
	# Faz a câmera de transição ser a câmera ativa no jogo
	transition_camera.make_current()
	
	# Coloca a câmera de transição exatamente na posição da câmera inicial
	transition_camera.global_position = selected_camera.global_position
	transition_camera.zoom = selected_camera.zoom

# Função PÚBLICA que as portas chamam para pedir a troca de câmera
func change_camera(camera_name: String):
	# Verifica se o nome da câmera existe no dicionário
	if cameras.has(camera_name):
		# Chama a função interna que faz a mágica do Tween
		_change_camera(cameras[camera_name])
	else:
		print("ERRO: Câmera não encontrada no dicionário: ", camera_name)

# Função INTERNA que executa a transição suave (Tween)
func _change_camera(desired_camera: Camera2D) -> void:
	# Se já estamos nessa câmera, não faz nada (evita loops)
	if selected_camera == desired_camera:
		return 
		
	# Se já houver uma animação rodando, cancela ela para começar uma nova
	if transition_tween:
		transition_tween.kill()
		
	# Cria um novo Tween. O set_parallel(true) permite animar posição e zoom AO MESMO TEMPO
	transition_tween = create_tween().set_parallel(true)
	
	# Anima a posição da câmera de transição até a posição da câmera desejada
	transition_tween.tween_property(transition_camera, "global_position", desired_camera.global_position, 0.5).set_trans(Tween.TRANS_SINE)
	
	# Anima o zoom da câmera de transição até o zoom da câmera desejada
	transition_tween.tween_property(transition_camera, "zoom", desired_camera.zoom, 0.5).set_trans(Tween.TRANS_SINE)
	
	# Atualiza a variável que diz qual é a câmera ativa agora
	selected_camera = desired_camera
