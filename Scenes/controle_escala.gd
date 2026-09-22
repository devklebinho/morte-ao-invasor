extends OptionButton


func _ready() -> void:
	# Inicia o jogo em tela cheia exclusiva
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
	)

	# Configuração inicial: 1920x1080
	alterar_resolucao(Vector2i(1920, 1080))


func _on_item_selected(index: int) -> void:

	if index == 0:
		# 1920x1080
		alterar_resolucao(Vector2i(1920, 1080))

	elif index == 1:
		# 1280x720
		alterar_resolucao(Vector2i(1280, 720))

	elif index == 2:
		# 1120x630
		alterar_resolucao(Vector2i(1120, 630))

	elif index == 3:
		# 800x450
		alterar_resolucao(Vector2i(800, 450))

	elif index == 4:
		# 640x360
		alterar_resolucao(Vector2i(640, 360))


func alterar_resolucao(resolucao: Vector2i) -> void:
	# Define a resolução interna/base do jogo
	get_tree().root.content_scale_size = resolucao
