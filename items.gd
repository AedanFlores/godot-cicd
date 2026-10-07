extends Area2D
@export var player:Node

func _ready() -> void:
	if player:
		body_entered.connect(player._on_body_entered)
	$AnimatedSprite2D.play("default")
	
func _on_body_entered(body: Node2D) -> void:
	queue_free()
