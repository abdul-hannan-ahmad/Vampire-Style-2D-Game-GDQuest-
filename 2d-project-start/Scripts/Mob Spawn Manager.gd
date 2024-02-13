extends Path2D

@onready var mob_spawn_location: PathFollow2D = $MobSpawnLocation
@onready var mob_spawn_timer: Timer = $MobSpawnTimer


func spawn_mob():
	var new_mob = preload("res://Scenes/Mob.tscn").instantiate()
	mob_spawn_location.progress_ratio = randf()
	new_mob.global_position = mob_spawn_location.global_position
	add_child(new_mob)	


func _on_game_scene_start_game() -> void:
	mob_spawn_timer.start()


func _on_mob_spawn_timer_timeout() -> void:
	spawn_mob()


func _on_game_scene_stop_game() -> void:
	mob_spawn_timer.stop()
