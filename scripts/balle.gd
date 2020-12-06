extends KinematicBody2D

export var speed = 500
var velocity = Vector2()

# créer un balle
func _creer(new_position, direction):
	position = new_position
	velocity = Vector2(speed,0).rotated(direction)

func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
