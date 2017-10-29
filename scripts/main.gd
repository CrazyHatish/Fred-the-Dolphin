extends Node2D

const cd = 20
var screen_size
var score = 0
var bullet
var curr_cd = 0

func _ready():
	bullet = load("res://scenes/bullet.tscn")
	set_fixed_process(true)
	screen_size = get_viewport_rect().size
	
func _fixed_process(delta):
	
	var fred_pos = get_node("fred").get_pos().y
		
	if (fred_pos > (screen_size.y + 100) or fred_pos < -100):
		get_tree().change_scene("res://scenes/menu.tscn")
		
	if (Input.is_action_pressed("shoot") and !curr_cd):
		var node = bullet.instance()
		get_node("bullets").add_child(node)
		curr_cd = cd
		get_node("fred/hand").play("shoot")
		get_node("fred/hand").set_frame(0)
	elif curr_cd > 0:
		curr_cd -= 1
	
func increment_score(amount):
	score += amount
	get_node("score").set_text(str(score))