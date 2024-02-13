extends Node2D

@onready var start_timer: Timer = $StartTimer
@onready var background_music: AudioStreamPlayer2D = $"Player/Background Music"
@onready var game_over_music: AudioStreamPlayer2D = $"Player/Game Over Music"
@onready var player_start_position: Marker2D = $PlayerStartPosition

signal start_game
signal stop_game

var mob_group


func _ready() -> void:
	new_game()
	
	
func _process(_delta: float) -> void:
	mob_group = get_tree().get_nodes_in_group("Mob")
	
	for i in mob_group:
		if not i.is_connected("increment_score", update_score):
			i.increment_score.connect(update_score)


func new_game():
	start_timer.start()
	background_music.play()
	$Player.global_position = player_start_position.global_position
	$Player.new_game()
	
	
func game_over():
	start_timer.stop()
	stop_game.emit()
	background_music.stop()
	game_over_music.play()
	for i in mob_group:
		i.queue_free()


func _on_start_timer_timeout() -> void:
	start_game.emit()


func _on_player_killed() -> void:
	game_over()


func _on_ui_manager_restart() -> void:
	new_game()
	
	
func update_score():
	$"UI Manager".score += 1
