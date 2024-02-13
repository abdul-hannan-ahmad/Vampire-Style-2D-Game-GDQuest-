extends CharacterBody2D

const SPEED = 600.0
const DAMAGE_RATE = 7.5

@onready var health_bar: ProgressBar = $HealthBar
@onready var hurt_box: Area2D = $HurtBox

var health: float

signal killed


func _ready() -> void:
	new_game()


func new_game():
	show()
	$CollisionShape2D.disabled = false
	health = 100
	health_bar.max_value = health
	
	
func game_over():
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	$HurtBox/CollisionShape2D.set_deferred("disabled", true)


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = direction * SPEED
	
	move_and_slide()
	
	if velocity.length() == 0:
		$HappyBoo.call("play_idle_animation")
	else:
		$HappyBoo.call("play_walk_animation")
		
	health_bar.value = health
	
	var hurting_enemies: Array = hurt_box.get_overlapping_bodies()
	
	if hurting_enemies.size() > 0:
		health -= hurting_enemies.size() * DAMAGE_RATE * delta
		
	if health <= 0:
		health = 1
		killed.emit()


func _on_killed() -> void:
	game_over()
