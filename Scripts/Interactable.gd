extends Area2D
class_name Interactable

# ============================================================
# SCRIPT BASE PARA OBJETOS INTERATIVOS
# ============================================================
# Qualquer objeto que herde deste script pode ser interagido pelo Player.
# Para usar: anexe este script (ou um que estenda ele) em uma Area2D.

# Texto que aparece quando o Player está perto (para UI futura)
@export var prompt_text: String = "Pressione E para interagir"

# Sinal emitido quando o Player interage com o objeto.
# Use isso para conectar lógicas específicas sem sobrescrever o script.
signal interacted(player: Node2D)

# Função chamada pelo PlayerInteractor quando o Player aperta a tecla.
# Pode ser sobrescrita em scripts filhos, ou você pode usar o sinal "interacted".
func interact(player: Node2D) -> void:
	print("Interagindo com: ", name)
	interacted.emit(player) # Avisa quem estiver escutando
