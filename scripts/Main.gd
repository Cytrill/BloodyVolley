extends Node2D

var kickoff = true
var team_kickoff = 1
var time_elapsed = 0
var pl_player = preload("res://scenes/Player.tscn")
var pl_ball = preload("res://scenes/Ball.tscn")
#Player Colors
const colarray = [Color(0, 0, 1), Color(0, 1, 0), Color(0, 1, 1),
	Color(1, 0, 0), Color(1, 0, 1), Color(1, 1, 0), Color(1, 1, 1),
	Color(1, 0, 0), Color(1, 0, 0.5), Color(0.5, 0, 1)]

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if kickoff:
		var ball = pl_ball.instance()
		if team_kickoff == 0:
			ball.set_pos(Vector2(760, 500))
		else:
			ball.set_pos(Vector2(1160, 500))
		get_node("Balls").add_child(ball)
		kickoff = false
		
	for i in range(0,128):
		if Input.is_joy_button_pressed(i, 0):
			if (!get_node("Players").has_node(cytrill.get_name(i))):
				print("Button has been presed!")
				#Reset countdown after two Players have joined the game:
				if (get_node("Players").get_child_count() == 1):
					time_elapsed = 0 #Reset Timer
				
				print(cytrill.get_name(i)+ " has joined the game!")
				var player = pl_player.instance()
				#player.set_player_scale(Vector2(0.6, 0.6))
				player.set_name(cytrill.get_name(i))
				if i%2 != 0:
					player.set_pos(Vector2(i*100+100, 100))
					player.team_number = 0
				else:
					player.set_pos(Vector2(1820-i*100, 100))
					player.team_number = 1
				player.player_number = i
				#highscore[cytrill.get_name(i)] = 0 #Init Playerscore
				#var texture_index = (i+1)
				
				#if (texture_index > texture_count):
				#	 texture_index = (i % texture_count)+1
				#var t = load("res://gfx/Player" + str(texture_index) + ".png")
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