extends CharacterBody2D
var HEALTH = 100
var speed = 60
var player_chase = false
var player = null
var facing_right = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var ray_cast= $RayCast2D


func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.y = 0
	
	velocity.x = speed
	
	if player_chase:
		position += (player.position - position)/speed
		$AnimatedSprite2D.play("run")
		if (player.position.x -position.x) < 0:
			$AnimatedSprite2D.flip_h =true
		else:
			$AnimatedSprite2D.flip_h =false
	
	if velocity.x != 0:
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")
		
	if !ray_cast.is_colliding() && is_on_floor():
		flip()
	
	move_and_slide()
	
func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false

func flip():
	facing_right != facing_right
	scale.x = abs(scale.x)*-1
	if(facing_right):
		speed = speed
	else:
		speed = -1*speed

func _on_detection_area_body_entered(body):
	if body is bullet:
		print("enemy hit")
		hit()
	elif body is playerClass:
		player = body
		player_chase = true
	else: 
		pass

func hit():
	if(HEALTH > 0 ):
		HEALTH -= 10;
	else:
		queue_free()
