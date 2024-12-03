class_name playerClass
extends CharacterBody2D
@onready var player = get_tree().root.get_child(0)
@onready var bullet = load("res://scenes/bullet.tscn")

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const RESET_POSITION = Vector2(0,0) #Reset position for the player
const OUT_OF_BOUNDS_Y = 725 #Y-coordinate below which the player resets
const SAFE_ZONE_Y = OUT_OF_BOUNDS_Y - 10  #Allowable buffer zone
const RESET_VELOCITY = Vector2(0,0)
var HEALTH = 100



@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera: Camera2D = $Camera2D

func _ready():
	camera.make_current()
	
func _physics_process(delta: float) -> void:
	
	#print("Player Postiion: ", global_position)
	#print("Is on floor: ", is_on_floor() )
	
	#Check if the player falls out of bounds
	if global_position.y > SAFE_ZONE_Y and not is_on_floor():
		#print("Reset triggered! Player Y position: ", global_position.y)
		reset_player_position()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.y = 0

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	#Flipping the sprite
	animated_sprite_2d.flip_h = direction < 0
	
	
	
	#Animations
	handle_animation(direction)
	
	#Horizontal movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#print("Before move_and_tile: velocity = ", velocity)
	move_and_slide()
	
	#Reset the player's position when out of bounds
func reset_player_position():
	#print("Resetting player current position: ", global_position)
	global_position = RESET_POSITION
	velocity = RESET_VELOCITY # Stop all movement
	#print("Player reset to:", RESET_POSITION)

func handle_animation(direction):
	var is_shooting := Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("shoot" if is_shooting else "idle")
			if is_shooting and Input.is_action_just_pressed("attack"):
				shoot()
		else:
			animated_sprite_2d.play("run-shoot" if is_shooting else "run")
		if is_shooting and Input.is_action_just_pressed("attack"):
			shoot()
	else:
		animated_sprite_2d.play("jump")


func shoot():
	var newBullet = bullet.instantiate()
	newBullet.dir = rotation
	newBullet.spawnPos = get_global_mouse_position()
	newBullet.rot = $bulletStart.rotation
	player.add_child(newBullet)
