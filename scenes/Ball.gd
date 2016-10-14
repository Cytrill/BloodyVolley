
extends Node2D
var body

func _ready():
	body = get_node("RigidBody2D")
	set_fixed_process(true)

func _fixed_process(delta):
	if (body.get_gravity_scale() == 0):
		if (body.get_colliding_bodies().size() > 0):
			body.set_gravity_scale(1)
	if (body.get_colliding_bodies().size() > 0):
		for b in body.get_colliding_bodies():
			if b.is_in_group( "Ground" ):
				if (body.get_global_pos().x < get_node("/root/World/Net").get_global_pos().x):
					get_node("/root/World").score(0)
				else:
					get_node("/root/World").score(1)
				
