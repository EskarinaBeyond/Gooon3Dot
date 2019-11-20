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
	
func change_player_cell(cell):
	
	var target = get_node("Ingame/Grid/Cell" + str(cell));
	var source = find_node("Player");
	self.remove_child(source);
	target.add_child(source);
	#source.set_owner(target);

func _process(delta):
	player = find_node("Player");
	print_debug(player.name);
	
	

