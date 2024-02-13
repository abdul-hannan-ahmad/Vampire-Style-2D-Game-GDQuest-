extends Area2D

@onready var shooting_point: Marker2D = %ShootingPoint
@onready var bullet_shoot_timer: Timer = $BulletShootTimer

var enemies_in_range: Array


func _process(_delta: float) -> void:
	enemies_in_range = get_overlapping_bodies()
	
	if enemies_in_range.size() > 0:
		var target_enemy: Node2D = enemies_in_range.front()
		
		look_at(target_enemy.global_position)
		
		
func shoot_bullet():
	var new_bullet = preload("res://Scenes/Bullet.tscn").instantiate()
	new_bullet.global_position = shooting_point.global_position
	new_bullet.global_rotation = shooting_point.global_rotation
	shooting_point.add_child(new_bullet)


func _on_game_scene_start_game() -> void:
	bullet_shoot_timer.start()


func _on_bullet_shoot_timer_timeout() -> void:
	if enemies_in_range.size() > 0:
		shoot_bullet()


func _on_game_scene_stop_game() -> void:
	bullet_shoot_timer.stop()
