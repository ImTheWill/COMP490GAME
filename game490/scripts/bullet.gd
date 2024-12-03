class_name bullet
extends CharacterBody2D
var dir: int
var rot: float
var spawnPos: Vector2
@export var SPEED = 500
var hasHit = false;


func _ready():
	global_position = spawnPos
	global_rotation = rot

func _physics_process(delta):
	velocity = Vector2(SPEED, 0 ).rotated(rot)
	move_and_slide()


func _on_collosion_dec_body_entered(body):
	queue_free()
	
func _to_string():
	return "bullet"
