extends Area2D

const SPEED = 1000.0
const MAX_RANGE = 1200.0

var travelled_distance = 0.0


func _process(delta: float) -> void:
	var direction  = Vector2.RIGHT.rotated(rotation)
	
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	
	if travelled_distance >= MAX_RANGE:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free()
	
	if body.has_method("take_damage"):
		body.call("take_damage")
