extends Spatial

var camera_anchor 
var camera 
var ingame
var grid
var RAY_LENGTH = 100


func _ready():
	camera_anchor = $Camera_Anchor;
	camera = $Camera_Anchor/Camera;
	ingame = $Ingame
	grid = $Ingame/Grid
	
	camera.grid_mid_point = grid.grid_mid_point;

