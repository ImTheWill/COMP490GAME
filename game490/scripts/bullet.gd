extends CharacterBody2D
var dir: int
var rot: float
var spawnPos: Vector2
@export var SPEED = 500


func _ready():
	global_position = spawnPos
	global_rotation = rot

func _physics_process(delta):
	velocity = Vector2(SPEED, 0 ).rotated(rot)
	move_and_slide()
