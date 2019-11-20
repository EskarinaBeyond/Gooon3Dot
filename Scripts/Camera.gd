extends Camera

var grid
var grid_mid_point
var camera_anchor


func _ready():
	
	camera_anchor = get_parent();
	
	grid = find_parent("Game").find_node("Grid")
	grid_mid_point = Vector3(grid.gridxsize *  grid.cellsize + grid.translation.x, grid.translation.y, grid.gridysize * grid.cellsize + grid.translation.z);
	print_debug(grid_mid_point);
	camera_anchor.translate(grid_mid_point)

func _process(delta):
	
	if Input.is_action_pressed("left"):
		camera_anchor.rotate_y(0.015);
		
	if Input.is_action_pressed("right"):
		camera_anchor.rotate_y(-0.015);
		
	if Input.is_action_pressed("forward"):
		camera_anchor.translate(Vector3(0, 0.03, 0));
		
	if Input.is_action_pressed("backward"):
		camera_anchor.translate(Vector3(0, -0.03, 0));