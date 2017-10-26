extends KinematicBody2D

const speed = Vector2(1000, 0)
var screen_size


func _ready():
	screen_size = get_viewport_rect().size
	set_pos(get_parent().get_node("fred").get_pos() + Vector2(112, -32))
	set_fixed_process(true)
	add_to_group("bullets")
	
func _fixed_process(delta):
	move(speed * delta)
	
	if get_pos().x > screen_size.x:
		queue_free()
