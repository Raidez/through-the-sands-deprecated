extends KinematicBody2D

class_name Ship

const mass = 20

var velocity: Vector2
var player_is_inside = false
var gravity : int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	velocity.y += gravity * mass * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var angle = rad2deg(collision.travel.angle())
		if abs(rotation_degrees - angle) < 30:
			rotation_degrees = angle

func push(velocity):
	# on ne peut pas pousser le bateau de l'intérieur
	if not player_is_inside:
		move_and_slide(velocity, Vector2.UP)

func _on_DontPushArea_body_entered(body: Node):
	if body.name == "Player":
		player_is_inside = true

func _on_DontPushArea_body_exited(body: Node):
	if body.name == "Player":
		player_is_inside = false
