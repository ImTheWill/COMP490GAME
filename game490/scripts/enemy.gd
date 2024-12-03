extends CharacterBody2D
var HEALTH = 100
var speed = 25
var player_chase = false
var player = null
var facing_right = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

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
	move_and_slide()
	
func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false

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
