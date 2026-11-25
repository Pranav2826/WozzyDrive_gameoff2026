extends Area2D
@export var truck: CharacterBody2D
@export var speed = 150
func _process(delta: float) -> void:
	position.y += speed*delta
	if position.y > 1100:
		queue_free()
