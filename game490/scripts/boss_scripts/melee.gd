extends State


func enter():
	super.enter()
	animation_player.play("cleave")

func transition():
	if owner.direction.length() > 60:
		get_parent().change_state("Follow")
