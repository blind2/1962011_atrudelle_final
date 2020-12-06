extends KinematicBody2D

export var speed = 50
onready var canon = $Canon
onready var shoot_delay = $Delay
onready var zone = $Zone
var velocity = Vector2()
var peut_bouger = false
onready var joueur_node = get_node("/root/"+Global.node_actuel+"/Joueur")

export(PackedScene) var balle = preload("res://scenes/BalleEnnemi.tscn")

func _ready():
	shoot_delay.set_wait_time(0.8)
	shoot_delay.start()

func _physics_process(delta):
	follow()
	var collision = move_and_collide(velocity*delta)
	if collision:
		if "Balle" in collision.collider.name:
			call_deferred('free')
			Global.ennemi_tuer+=1

func shoot():
	var balle_instance1 = balle.instance()	
	var balle_instance2 = balle.instance()
	var balle_instance3 = balle.instance()
	balle_instance1.rotation =rotation
	balle_instance2.rotation = rotation
	balle_instance3.rotation = rotation
	
	balle_instance1._creer(canon.global_position,rotation)
	balle_instance2._creer(canon.global_position,rotation+100)
	balle_instance3._creer(canon.global_position,rotation-100)
	get_parent().add_child(balle_instance1)
	get_parent().add_child(balle_instance2)
	get_parent().add_child(balle_instance3)

func follow():
	if peut_bouger:
		var dirrection = joueur_node.position-position
		rotation = dirrection.angle()
		velocity = Vector2(speed,0).rotated(rotation)
	

func _on_Delay_timeout():
	if peut_bouger:
		shoot()
	

func _on_Zone_body_entered(body):
	if "Joueur" in body.name:
		peut_bouger = true

