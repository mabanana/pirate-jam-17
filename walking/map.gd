extends Node3D

var floor_plane
var floor_size
var cell_size = 1.0
var margin = 1
var grid_map = {}
var grid_pos = [0,0]

# Called when the node enters the scene tree for the first time.
func _ready():
	floor_plane = $FloorPlane
	floor_size = floor_plane.mesh.size
	var rows = floor_size.x / cell_size - margin*2 + 1
	var cols = floor_size.y / cell_size - margin*2 + 1
	for row in range(rows):
		for col in range(cols):
			var top_left = position - Vector3(floor_size.x / 2, position.y, floor_size.y / 2)
			
			grid_map[[row, col]] = top_left + Vector3(margin*cell_size*(row+margin), 0, margin*cell_size*(col+margin))
			
			pass
	
	$"../Player".player_moved.connect(_move_player)
	$"../Player".position = grid_map[grid_pos]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func _input(event):
	pass

func _on_view_change():
	if $"../Player/Camera3D".current:
		$"../Player/Camera3D".current = false
		$"../Overview".current = true
	else:
		$"../Player/Camera3D".current = true
		$"../Overview".current = false

func _move_player(dir):
	var x = dir[0]
	var y = dir[2]
	if [grid_pos[0] + x, grid_pos[1] + y] in grid_map:
		grid_pos[0] += x
		grid_pos[1] += y
	
	$"../Player".move_tween(grid_map[grid_pos])
