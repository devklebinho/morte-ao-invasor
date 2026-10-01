extends Node
# ============================================================
# MUSIC MANAGER
# ============================================================
# Gerencia a música de fundo do jogo.
# Deve ser registrado como Autoload para persistir entre cenas.

# Player de áudio que toca a música
var music_player: AudioStreamPlayer

# Guarda a música atual para evitar reiniciar a mesma faixa
var current_music: AudioStream = null


func _ready():
	# Cria o player de áudio dinamicamente
	music_player = AudioStreamPlayer.new()
	add_child(music_player)


# ============================================================
# MÉTODOS PÚBLICOS
# ============================================================

# Toca uma música. Se a mesma já estiver tocando, não faz nada.
func play_music(stream: AudioStream, volume_db: float = 0.0):
	# Se for a mesma música e já está tocando, ignora
	if current_music == stream and music_player.playing:
		return
	
	current_music = stream
	music_player.stream = stream
	music_player.volume_db = volume_db
	music_player.play()


# Para a música atual.
func stop_music():
	music_player.stop()
	current_music = null


# Ajusta o volume da música (em decibéis).
# -80 = mudo, 0 = volume máximo.
func set_volume(volume_db: float):
	music_player.volume_db = volume_db


# Verifica se a música está tocando.
func is_playing() -> bool:
	return music_player.playing
