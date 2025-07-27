extends Node3D

@export var floor_plane: MeshInstance3D
@export var floor_size = Vector2(6, 8)
var cell_size = 2.0
var margin = 1
var grid_map = {}
var grid_pos = [1,2]

var player_move_requested = Signals.player_move_requested
var player_move_resolved = Signals.player_move_resolved

var object_map = {
	"mattress": [0, 2],
}

# Called when the node enters the scene tree for the first time.
func _ready():
	floor_plane.mesh.size = floor_size
	var rows = floor_size.x / cell_size - margin*2 + 1
	var cols = floor_size.y / cell_size - margin*2 + 1
	for row in range(rows):
		for col in range(cols):
			var top_left = position - Vector3(floor_size.x / 2, position.y, floor_size.y / 2)
			grid_map[[row, col]] = top_left + Vector3( margin*cell_size*(row+margin), 0, margin*cell_size*(col+margin))
	for object_grid_pos in object_map.values():
		if object_grid_pos in grid_map:
			grid_map.erase(object_grid_pos)
	player_move_requested.connect(_move_player)
	$"../Player".position = grid_map[grid_pos]
	# Add bathroom grid pos
	grid_map[[-1, 0]] = Vector3(-4.5, 0, -2)


func _move_player(dir):
	var x = dir[0]
	var y = dir[2]
	if [grid_pos[0] + x, grid_pos[1] + y] in grid_map:
		grid_pos[0] += x
		grid_pos[1] += y
	
	player_move_resolved.emit(grid_map[grid_pos])
