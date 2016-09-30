extends Node2D

var player_number = 0
var joy_tresh = 0.2

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	get_node("PlayerBody").set_rot(0)
	
	handle_input()

func handle_input():
	if Input.get_joy_axis(player_number,  0) < -joy_tresh:
		get_node("PlayerBody").apply_impulse(Vector2(0,0), Vector2(-10, 0))
	elif Input.get_joy_axis(player_number,  0) > joy_tresh:
		get_node("PlayerBody").apply_impulse(Vector2(0,0), Vector2(10, 0))
	else:
		get_node("PlayerBody").apply_impulse(Vector2(0,0), Vector2(-get_node("PlayerBody").get_linear_velocity().x*0.5, 0))