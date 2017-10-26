extends Node2D

var clouds = []
const chance = 0.8
const speed = 200

func _ready():
	for i in range(1, 5):
		clouds.append(load("res://scenes/cloud{0}.tscn".format([i])))
	randomize()
	set_fixed_process(true)
	
func _fixed_process(delta):
	if rand_range(0, 1) < (chance * delta):
		var node = clouds[int(round(rand_range(0, 3)))].instance()
		var z = int(round(rand_range(-3, 0)))
		node.set_pos(Vector2(0, rand_range(0, 1280)))
		node.set_z(z)
		node.set_scale(Vector2(1/sqrt(abs(z) + 1), 1/(sqrt(abs(z) + 1))))
		add_child(node)

	for child in get_children():
		child.move_local_x(-speed * delta * 1/sqrt(abs(child.get_z()) + 1))
		if child.get_global_pos().x < -100:
			child.queue_free()
