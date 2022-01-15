extends Camera2D

export (NodePath) var player_path
export (NodePath) var ship_path
onready var player = get_node(player_path)
onready var ship = get_node(ship_path)

func _process(delta):
	var a = player.get_node("CameraPivot").global_position
	var b = ship.get_node("CameraPivot").global_position
	var center = a.linear_interpolate(b, 0.5)
	position = center
