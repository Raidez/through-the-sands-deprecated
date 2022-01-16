extends KinematicBody2D

class_name Player

const speed = 350
const acceleration = 0.09
const friction = 0.2
const mass = 20
const jump_height = 600

const push_crate_speed = 50
const push_ship_speed = 50

var velocity: Vector2
var gravity : int = ProjectSettings.get_setting("physics/2d/default_gravity")
var collision: KinematicCollision2D

func _physics_process(delta):
	# détermine la direction
	var movement = get_input()

	# calcul du mouvement (direction, gravité, etc)
	calculate_velocity(movement, delta)

	# déplacement
	velocity = move_and_slide(velocity, Vector2.UP, true, 4, PI/4, false)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider is Ship:
			move_ship(collision.collider, -collision.normal)
		if collision.collider.is_in_group("crate"):
			move_crate(collision.collider, -collision.normal)

func get_input():
	var movement = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		movement.x = 1
	if Input.is_action_pressed("move_left"):
		movement.x = -1
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_height
	
	return movement
	
func calculate_velocity(movement: Vector2, delta):
	# déplacement
	if movement.length() > 0:
		velocity.x = lerp(velocity.x, movement.x * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	
	# gravité
	velocity.y += gravity * mass * delta

func move_ship(ship: Ship, direction: Vector2):
	# déplace le bateau horizontalement
	direction.y = 0
	ship.push(direction * push_ship_speed)

func move_crate(crate: RigidBody2D, direction: Vector2):
	# déplace la caisse horizontalement
	direction.y = 0
	crate.apply_central_impulse(direction * push_crate_speed)
