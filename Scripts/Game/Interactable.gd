extends Area2D
class_name Interactable

# ============================================================
# SCRIPT BASE PARA OBJETOS INTERATIVOS
# ============================================================
# Qualquer objeto que herde deste script pode ser interagido pelo Player.

# Texto que aparece quando o Player está perto (para UI futura)
@export var prompt_text: String = "Pressione E para interagir"

# Nome do item (ex: "Poção de Vida", "Chave Dourada", "Martelo")
@export var item_name: String = "Item"

# NOVO: Se verdadeiro, o objeto some após ser interagido (é coletável).
# Se falso, o objeto permanece (ex: uma alavanca, um baú que abre e fecha).
@export var is_collectable: bool = true

# Sinal emitido quando o Player interage com o objeto.
signal interacted(player: Node2D)

# NOVO: Sinal emitido quando o item é coletado (com o nome do item).
signal picked_up(item_name: String)


# Função chamada pelo PlayerInteractor quando o Player aperta a tecla.
func interact(player: Node2D) -> void:
	print("Interagindo com: ", name)
	
	# Emite o sinal genérico de interação
	interacted.emit(player)
	
	# Se for coletável, executa a lógica de coleta
	if is_collectable:
		print("Item coletado: ", item_name)
		# Emite o sinal avisando a UI/Player
		picked_up.emit(item_name)
		# Remove o objeto da cena
		queue_free()
