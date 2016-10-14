extends Node2D

var kickoff = true
var team_kickoff = 0
var time_elapsed = 0
var pl_player = preload("res://scenes/Player.tscn")
var pl_ball = preload("res://scenes/Ball.tscn")
var ball = null

var score_left = 0
var score_right = 0

#Player Colors
const colarray = [Color(0, 0, 1), Color(0, 1, 0), Color(0, 1, 1),
	Color(1, 0, 0), Color(1, 0, 1), Color(1, 1, 0), Color(1, 1, 1),
	Color(1, 0, 0), Color(1, 0, 0.5), Color(0.5, 0, 1)]

func score(team):
	if (team == 0):
		score_left+=1
		team_kickoff=1
	else:
		score_right+=1
		team_kickoff=0
	get_node("GUI/ScoreLeft").set_text(str(score_left))
	get_node("GUI/ScoreRight").set_text(str(score_right))
	
	kickoff = true
	
	
func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if kickoff:
		if ball == null:
			ball = pl_ball.instance()
			get_node("Balls").add_child(ball)
		var ball_body = ball.get_node("RigidBody2D")
		ball_body.set_linear_velocity(Vector2(0,0))
		if team_kickoff == 0:
			ball_body.set_global_pos(Vector2(get_viewport_rect().size.width/3,400))
		else:
			ball_body.set_global_pos(Vector2( get_viewport_rect().size.width - (get_viewport_rect().size.width/3),400))
		ball_body.set_gravity_scale(0)
		kickoff = false
	
	for i in range(0,128):
		if Input.is_action_pressed("player"+str(i)+"_jump"):
			if (!get_node("Players").has_node("Action"+str(i))):
				var player = pl_player.instance()
				player.set_name("Action"+str(i))
				player.input_type = player.IT_ACTIONS
				player.set_pos(Vector2(i*100+100, 100))
				var action_player_id = i
				for p in get_node("Players").get_children():
					if (p.input_type == player.IT_ACTIONS):
						action_player_id = i
				player.action_player_id = action_player_id
				player.team_number = get_node("Players").get_child_count() % 2
				player.player_number = i
				if player.team_number != 0:
					player.set_pos(Vector2(i*100+100, 100))
				else:
					player.set_pos(Vector2(1820-i*100, 100))
				player.add_to_group("Players")
				player.get_node("PlayerBody/PlayerSprite").set_modulate(colarray[i%10])
				player.get_node("Shadow").set_modulate(colarray[i%10])
				get_node("Players").add_child(player)
				
	
	for i in range(0,128):
		if Input.is_joy_button_pressed(i, 0):
			if (!get_node("Players").has_node(cytrill.get_name(i))):
				print("Button has been presed!")
				#Reset countdown after two Players have joined the game:
				if (get_node("Players").get_child_count() == 1):
					time_elapsed = 0 #Reset Timer
				
				print(cytrill.get_name(i)+ " has joined the game!")
				var player = pl_player.instance()
				
				player.input_type = player.IT_JOYSTICK
				player.set_name(cytrill.get_name(i))
				player.team_number = get_node("Players").get_child_count() % 2
				if player.team_number != 0:
					player.set_pos(Vector2(i*100+100, 100))
				else:
					player.set_pos(Vector2(1820-i*100, 100))
				player.player_number = i
				player.add_to_group("Players")
				var color = Color(1,1,1)
				color.s = 1
				color.h = i*0.05 #Change Hue using player index
				cytrill.set_led(i, 0, colarray[i%10].r*255, colarray[i%10].g*255, colarray[i%10].b*255, 2)
				cytrill.set_led(i, 1, colarray[i%10].r*255, colarray[i%10].g*255, colarray[i%10].b*255, 2)
				player.get_node("PlayerBody/PlayerSprite").set_modulate(colarray[i%10])
				player.get_node("Shadow").set_modulate(colarray[i%10])
				#player.get_node("Sprite").set_texture(t)
				get_node("Players").add_child(player)