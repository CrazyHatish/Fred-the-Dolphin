extends KinematicBody2D

const gravity = 330
const max_speed = 500
var fly = -1000
var speed = Vector2(0, 0)

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var acc = Vector2(0, gravity)
	
	if Input.is_action_pressed("up"):
		acc.y += fly
		pack_start(get_node("fire"))
		get_node("fred").set_frame(0)
		
	else:
		pack_stop(get_node("fire"))
		get_node("fred").set_frame(1)

	speed += acc * delta
	
	move(speed * delta)
	
func pack_start(anim):
	if anim.get_animation() == "idle":
		anim.play("pack_start")
	if anim.get_animation() == "pack_stop":
		var frame = 3 - anim.get_frame()
		anim.play("pack_start")
		anim.set_frame(frame)
	if (anim.get_animation() == "pack_start" and anim.get_frame() == 5):
		anim.set_animation("fire_idle")
		
func pack_stop(anim):
	if anim.get_animation() == "fire_idle":
		anim.play("pack_stop")
	if anim.get_animation() == "pack_start":
		var frame = 5 - anim.get_frame()
		anim.play("pack_stop")
		anim.set_frame(frame)
	if (anim.get_animation() == "pack_stop" and anim.get_frame() == 4):
		anim.set_animation("idle")
		