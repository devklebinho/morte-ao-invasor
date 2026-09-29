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


func _ready():
	# Conecta os sinais de entrada e saída de corpos na área.
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	# Conecta também para Area2D (caso o interativo seja uma Area2D, 
	# que é o caso do nosso Interactable).
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


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
