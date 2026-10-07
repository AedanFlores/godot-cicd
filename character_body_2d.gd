extends CharacterBody2D
@export var direction = 1
var points=0
var SPEED = 300.0
const JUMP_VELOCITY=-400.0
func _ready():
	points=Global.points

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("run"):
		SPEED=600
	elif Input.is_action_just_released("run"):
		SPEED=300
	
	var direction := Input.get_axis("move_left","move_right")
	if direction:
		velocity.x= direction * SPEED
		$Avatar.play("Walk")
		$Avatar.flip_v = false
		$Avatar.flip_h = velocity.x <0
	else: 
		$Avatar.play("Idle")
		velocity.x = move_toward(velocity.x,0,SPEED)
	move_and_slide()

@export var start_position= Vector2(580,-144)
func respawn():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	respawn()


func _on_item_body_entered(body: Node2D) -> void:
	points+=1
	Global.points=points
	$CanvasLayer/Label.text= "Score: %s" %points
	if points==7:
		get_tree().change_scene_to_file("res://level_2.tscn")
func _on_enemy_1_squashed():
	pass
