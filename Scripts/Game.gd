extends Spatial

var camera_anchor 
var camera 
var ingame
var player
var grid
var RAY_LENGTH = 100
var starting_cell = 2


func _ready():
	camera_anchor = $Camera_Anchor;
	camera = $Camera_Anchor/Camera;
	ingame = $Ingame
	grid = $Ingame/Grid
	player = find_node("Player");
	
	
	camera.grid_mid_point = grid.grid_mid_point;
	
	player.change_player_cell(get_node("Ingame/Grid/Cell").get_path());
	

func _process(delta):
	pass;
	
	

