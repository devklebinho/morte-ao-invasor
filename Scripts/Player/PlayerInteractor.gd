extends Area2D

# ============================================================
# PLAYER INTERACTOR
# ============================================================
# Detecta objetos interativos próximos e responde ao input.

var nearby_interactables: Array[Interactable] = []

@onready var player: Node2D = get_parent()


func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


func _on_body_entered(body: Node2D):
	if body is Interactable:
		nearby_interactables.append(body)

func _on_body_exited(body: Node2D):
	if body is Interactable:
		nearby_interactables.erase(body)

func _on_area_entered(area: Area2D):
	if area is Interactable:
		nearby_interactables.append(area)

func _on_area_exited(area: Area2D):
	if area is Interactable:
		nearby_interactables.erase(area)


func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("Interact"):
		if nearby_interactables.size() > 0:
			var target = nearby_interactables[0]
			target.interact(player)
