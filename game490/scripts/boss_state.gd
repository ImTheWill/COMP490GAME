extends Node2D
class_name State

@onready var debug = owner.find_child("debug")
@onready var player = owner.get_parent().find_child("player")
@onready var animation_player = owner.find_child("AnimationPlayer")


#turn off physics process
func _ready():
	set_physics_process(false)

#turns on physics process using functions
func enter():
	set_physics_process(true)

func exit():
	set_physics_process(false)

#switch between states
func transition():
	pass

func _physics_process(_delta):
	transition()
	debug.text = name
