extends CharacterBody2D
@onready var bullet = load("res://scenes/bullet.tscn")
@onready var player = get_parent().find_child("Player")
@onready var sprite = $Sprite2D
@onready var progress_bar: ProgressBar = $UI/ProgressBar

var direction : Vector2

var health = 100:
	set(value):
		health = value
		progress_bar.value = value
		if value <= 0:
			progress_bar.visible = false
			find_child("FiniteStateMachine").change_state("Death")

func take_damage():
	health -= 10

func _ready():
	set_physics_process(false)

func _process(_delta):
	if(health < 0 ):
		find_child("FiniteStateMachine").change_state("Death")
		queue_free()
	else:
		direction = player.position - position
		if direction.x < 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true

func _physics_process(delta):
	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta)
