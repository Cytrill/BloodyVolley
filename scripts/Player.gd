extends Node2D

var player_number = 0
var joy_tresh = 0.2
var jump_ready = true
var jump_timer = 0.0
var jump_time = 1.0

func _ready():
	get_node("PlayerBody/RayCast2D").add_exception(get_node("PlayerBody"))
	set_fixed_process(true)

func _fixed_process(delta):
	get_node("PlayerBody").set_rot(0)
	
	handle_input(delta)
	
	get_node("Shadow").set_global_pos(Vector2(get_node("PlayerBody").get_global_pos().x, 885))
	
	var shadow_scale = (abs(get_node("PlayerBody").get_global_pos().y - 846)*0.0005)+0.6
	get_node("Shadow").set_scale(Vector2(shadow_scale, shadow_scale))
	
	jump_timer += delta
	if jump_timer >= jump_time && get_node("PlayerBody/RayCast2D").is_colliding() && get_node("PlayerBody/RayCast2D").get_collider().is_in_group("Ground"):
		jump_ready = true
		jump_timer = 0.0

func handle_input(delta):
	if Input.get_joy_axis(player_number,  0) < -joy_tresh:
		get_node("PlayerBody").apply_impulse(Vector2(0,30), Vector2(-20, 0))
	elif Input.get_joy_axis(player_number,  0) > joy_tresh:
		get_node("PlayerBody").apply_impulse(Vector2(0,30), Vector2(20, 0))
	else:
		get_node("PlayerBody").apply_impulse(Vector2(0,0), Vector2(-get_node("PlayerBody").get_linear_velocity().x*0.5, 0))
	if jump_ready && Input.get_joy_axis(player_number, 1) < -joy_tresh:
		get_node("PlayerBody").apply_impulse(Vector2(0, 30), Vector2(0, -1100))
		jump_ready = false
		print("Jump")