extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera: Camera2D = $Camera2D

func _ready():
	camera.make_current()
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	#Flipping the sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	var is_shooting := Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	
	#Animations
	if is_on_floor():
		if direction == 0:
			if is_shooting == true:
				animated_sprite_2d.play("shoot")
			else:
				animated_sprite_2d.play("idle")
		else:
			if is_shooting == true:
				animated_sprite_2d.play("run-shoot")
			else:
				animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
	
	
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
