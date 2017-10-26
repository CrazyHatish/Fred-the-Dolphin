extends Node2D

const max_speed = 600
var speed = 200
const min_cd = 2
var time = 4
var curr_cd = 0
var waves = []

func _ready():
	set_process(true)
	for i in range(5):
		var wave = 'res://scenes/wave{0}.tscn'.format([i+1])
		waves.append(load(wave))
	randomize()
	
func _process(delta):
	if curr_cd <= 0:
		var wave = int(round(rand_range(0, 4)))
		var node = waves[wave].instance()
		for child in node.get_children():
			child.set("speed", speed)
		add_child(node)
		curr_cd = min_cd + time
		if time > 0:
			time -= 0.2
		if speed < max_speed:
			speed += 10
		
	curr_cd -= delta
	