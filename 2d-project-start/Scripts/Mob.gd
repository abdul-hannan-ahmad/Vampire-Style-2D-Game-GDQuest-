extends CharacterBody2D

const SPEED = 200.0

@onready var player = get_node("/root/Game Scene/Player")
@onready var health_bar: ProgressBar = $HealthBar

var health: int

signal increment_score


func _ready() -> void:
	new_game()


func new_game():
	health = 3
	$Slime.call("play_walk")
	health_bar.max_value = health


func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	
	velocity = direction * SPEED
	
	move_and_slide()
	
	health_bar.value = health
	
	
func take_damage():
	health -= 1
	$Slime.call("play_hurt")
	
	if health <= 0:
		queue_free()
		var SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn").instantiate()
		SMOKE_SCENE.global_position = global_position
		get_parent().add_child(SMOKE_SCENE)
		increment_score.emit()
