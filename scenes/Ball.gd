
extends Node2D
var body

func _ready():
	body = get_node("RigidBody2D")
	set_fixed_process(true)

func _fixed_process(delta):
	if (body.get_gravity_scale() == 0):
		if (body.get_colliding_bodies().size() > 0):
			body.set_gravity_scale(1)
