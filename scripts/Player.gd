extends KinematicBody2D

enum STATE { MOVE, PUSH }
const speed = 350
const speed_push = 100
const accel = 0.09
const deaccel = 0.2
const push_crate = Vector2(20, 0)

var velocity: Vector2
var gravity: Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
var state = STATE.MOVE
var collision: KinematicCollision2D

func _process(delta):
	# détermine la direction
	var movement = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		movement.x = +1
	elif Input.is_action_pressed("move_left"):
		movement.x = -1
	
	# accélération/déaccélération
	if state == STATE.MOVE:
		move(movement)
	elif state == STATE.PUSH:
		push(movement)
	
	# collision
	collision = move_and_collide(velocity * delta, false)
	if collision and collision.collider is RigidBody2D:
		state = STATE.PUSH
		collision.collider.apply_central_impulse(push_crate)
	else:
		state = STATE.MOVE

func move(movement: Vector2):
	if movement.length() > 0:
		velocity = velocity.linear_interpolate(movement * speed, accel)
	else:
		velocity = velocity.linear_interpolate(Vector2.ZERO, deaccel)

func push(movement: Vector2):
	if movement.length() > 0:
		velocity = velocity.linear_interpolate(movement * speed_push, accel)
	else:
		velocity = velocity.linear_interpolate(Vector2.ZERO, deaccel)
