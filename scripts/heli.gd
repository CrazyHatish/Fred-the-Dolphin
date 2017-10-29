extends Node2D

export var speed = 400
export var type = 0
var gravity = 0
var direction = [-1, 1]
var loc = 0
var dead = false
var main
var points
var score = 0

func _on_heli_body_enter(body):
	if 'bullets' in body.get_groups():
		body.queue_free()
		get_node("explosion").play()
		get_node("body").set_collision_mask(0)
		get_node("blades").set_collision_mask(0)
		get_node("body").set_layer_mask(0)
		get_node("blades").set_layer_mask(0)
		if type == 1:
			main.get_tree().change_scene("res://scenes/menu.tscn")
		elif !dead:
			main.increment_score(score)
			var node = points.instance()
			node.get_node("Label").set_text(str(score))
			add_child(node)
			
			
	if body.get_name() == 'fred':
		main.get_tree().change_scene("res://scenes/menu.tscn")
		
func _on_blades_body_enter(body):
	if 'bullets' in body.get_groups():
		body.queue_free()
		if !dead:
			main.increment_score(2 * score)
			var node = points.instance()
			node.get_node("Label").set_text(str(2 * score))
			add_child(node)
		dead = true
	
	if body.get_name() == 'fred':
		main.get_tree().change_scene("res://scenes/menu.tscn")

func _ready():
	points = load("res://scenes/points.tscn")
	randomize()
	direction = direction[int(rand_range(0, 1))]
	set_pos(Vector2(get_pos().x + rand_range(-20, 20), get_pos().y + rand_range(-20, 20)))
	get_node("AnimatedSprite").set_frame(int(round(rand_range(0, 2))))
	set_fixed_process(true)
	if type == 1:
		get_node("AnimatedSprite").set_animation("bad")
	add_to_group("enemies")
	main = get_node("/root/main")
	score = 50 + type * 50
	
func _fixed_process(delta):
	
	var anim = get_node("AnimatedSprite")
	
	if (type == 2):
		if abs(get_pos().y) > 150:
			direction = -direction
		move_local_y(direction * speed/2 * delta)
		move_local_x(-speed * delta)
	else:
		move_local_x(-speed * delta)
		
	if dead:
		gravity += 20
		move_local_y(gravity * delta)
		for child in get_children():
			if child.get_z() != 2:
				child.set_rotd(gravity/80)
			else:
				child.move_local_y(-gravity * delta)
		if type == 1:
			anim.set_animation("bad_blade")
		else:
			anim.set_animation("blade")
	
	if (get_global_pos().x < -200 or get_global_pos().y > 2000):
		queue_free()
	
	if get_node("explosion").is_playing() == true:
		if get_node("explosion").get_frame() == 7 and !get_node("points/AnimationPlayer").is_playing():
			queue_free()
		elif get_node("explosion").get_frame() == 3:
			anim.hide()
