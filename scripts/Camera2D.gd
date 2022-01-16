extends Camera2D

export (NodePath) var player_path
export (NodePath) var ship_path
onready var player = get_node(player_path)
onready var ship = get_node(ship_path)

const max_distance = 572

func _process(delta):
	# détermine la position de la caméra entre le bateau et le joueur
	var a = player.get_node("CameraPivot").global_position
	var b = ship.get_node("CameraPivot").global_position
	if a.distance_to(b) < max_distance:
		var center = a.linear_interpolate(b, 0.5)
		position = center
	else:
		position = a
