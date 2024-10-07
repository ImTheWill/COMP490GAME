extends ParallaxLayer

@export var SCROLL_SPEED: float = -15.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.motion_offset.x += SCROLL_SPEED * delta
	
