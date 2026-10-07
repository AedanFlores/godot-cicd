extends CharacterBody2D
signal squashed
@export var player:Node
@export var direction = 1
@export var speed = 200.0
func _ready():
	if direction == 1 :
		$AnimatedSprite2D.flip_h=false
	else:
		$AnimatedSprite2D.flip_h=true
	if player:
		squashed.connect(player._on_enemy_1_squashed)
		$Sides.body_entered.connect(player._on_sides_body_entered)
		
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	velocity.x = direction*speed
	$AnimatedSprite2D.play("defaultwalk")
	move_and_slide()


func _on_area_body_entered(body: Node2D) -> void:
	direction=-direction


func _on_head_body_entered(body: Node2D) -> void:
	direction=0
	squashed.emit(self)
	
	queue_free()


func _on_nofall_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	direction=-direction
