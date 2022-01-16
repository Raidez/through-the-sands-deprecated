extends KinematicBody2D

class_name Ship

const gravity_scale = 20
const friction = 0.2

var velocity: Vector2
var player_is_inside = false
var gravity : int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# ralentissement
	velocity.x = lerp(velocity.x, 0, friction)
	
	# gravité
	velocity.y += gravity * gravity_scale * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func push(p_velocity):
	# on ne peut pas pousser le bateau de l'intérieur
	if not player_is_inside:
		velocity = move_and_slide(p_velocity, Vector2.UP)

func _on_DontPushArea_body_entered(body: Node):
	if body.name == "Player":
		player_is_inside = true

func _on_DontPushArea_body_exited(body: Node):
	if body.name == "Player":
		player_is_inside = false
