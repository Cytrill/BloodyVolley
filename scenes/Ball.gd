
extends Node2D
var body

func _ready():
	body = get_node("RigidBody2D")
	set_fixed_process(true)

func _fixed_process(delta):
	
	get_node("Shadow").set_global_pos(Vector2(body.get_global_pos().x, 885))
	var shadow_scale = (abs(body.get_global_pos().y - 846)*0.0005)+0.6
	get_node("Shadow").set_scale(Vector2(shadow_scale/1.5, shadow_scale/4))
	
	if (body.get_gravity_scale() == 0):
		body.set_angular_velocity(10)
		if (body.get_colliding_bodies().size() > 0):
			body.set_gravity_scale(1)
	if (body.get_colliding_bodies().size() > 0):
		get_node("SamplePlayer2D").play("ball_hit")
		for b in body.get_colliding_bodies():
			if b.is_in_group( "Ground" ):
				get_node("SamplePlayer2D").play("score")
				if (body.get_global_pos().x < get_node("/root/World/Net").get_global_pos().x):
					get_node("/root/World").score(0)
				else:
					get_node("/root/World").score(1)
				
