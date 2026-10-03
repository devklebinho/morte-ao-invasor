extends Area2D

# ============================================================
# PLAYER INTERACTOR
# ============================================================
# Este script fica na InteractionArea (filha do Player).
# Ele detecta objetos do tipo "Interactable" próximos e responde 
# ao input do jogador para interagir.

# Lista de objetos interativos atualmente próximos ao Player.
var nearby_interactables: Array[Interactable] = []

# Referência ao Player (o nó pai desta Area2D).
@onready var player: Node2D = get_parent()

# Referência à Label de mensagens (ajuste o caminho se necessário)
@onready var message_label: Label = player.get_node("UILayer/UILabel")

# Timer para esconder a mensagem depois de um tempo
@onready var message_timer: Timer = Timer.new()


func _ready():
	# Conecta os sinais de entrada e saída de corpos na área.
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	# Conecta também para Area2D (caso o interativo seja uma Area2D, 
	# que é o caso do nosso Interactable).
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	
	# Configura o timer que esconde a mensagem
	message_timer.one_shot = true
	message_timer.wait_time = 2.0 # 2 segundos
	message_timer.timeout.connect(_on_message_timer_timeout)
	add_child(message_timer)


# ============================================================
# DETECÇÃO DE OBJETOS PRÓXIMOS
# ============================================================

func _on_body_entered(body: Node2D):
	# Se o corpo que entrou é um Interactable, adiciona à lista.
	if body is Interactable:
		nearby_interactables.append(body)
		print("Perto de: ", body.name)

func _on_body_exited(body: Node2D):
	# Remove da lista quando sai.
	if body is Interactable:
		nearby_interactables.erase(body)

# Como Interactable é uma Area2D, precisamos detectar áreas também.
func _on_area_entered(area: Area2D):
	if area is Interactable:
		nearby_interactables.append(area)
		# NOVO: Conecta o sinal "picked_up" do objeto
		area.picked_up.connect(_on_item_picked_up)
		print("Perto de: ", area.name)

func _on_area_exited(area: Area2D):
	if area is Interactable:
		nearby_interactables.erase(area)


# ============================================================
# INPUT DE INTERAÇÃO
# ============================================================

func _unhandled_input(event: InputEvent):
	# Verifica se a tecla de interação foi pressionada.
	if event.is_action_pressed("Interact"):
		# Se houver algum objeto próximo, interage com o primeiro.
		if nearby_interactables.size() > 0:
			var target = nearby_interactables[0]
			target.interact(player)
			print("Interagindo com: ", target.name)
		else:
			print("Nada para interagir por perto.")


# ============================================================
# SISTEMA DE MENSAGENS (UI)
# ============================================================

func _on_item_picked_up(item_name: String):
	show_message("Você pegou: " + item_name)

func show_message(text: String):
	message_label.text = text
	message_label.visible = true
	message_timer.start()

func _on_message_timer_timeout():
	message_label.visible = false
