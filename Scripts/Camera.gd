extends Camera

onready var camera_anchor = get_parent();
onready var grid = find_parent("Game").find_node("Grid")
onready var grid_mid_point = grid.grid_mid_point;



func _ready():
	
	camera_anchor.translate(grid_mid_point);

func _process(delta):
	
	#My mess of a camera control system
	
	if Input.is_action_pressed("left"):
		camera_anchor.rotate_y(0.015);
		
	if Input.is_action_pressed("right"):
		camera_anchor.rotate_y(-0.015);
	
	if Input.is_action_pressed("forward"):
		if rotation.x <= 0:
			rotate_x(0.015);
	
	if Input.is_action_pressed("backward"):
		if rotation.x >= -1.2:
			rotate_x(-0.015);
	
	if Input.is_action_pressed("up"):
		camera_anchor.translate(Vector3(0, 0.1, 0));
		
	if Input.is_action_pressed("down"):
		camera_anchor.translate(Vector3(0, -0.1, 0));
	
	if Input.is_action_pressed("zoom_in"):
		if translation.z > 6:
			translate(Vector3(0, 0, -0.1));
	
	if Input.is_action_pressed("zoom_out"):
		if translation.z < 30:
			translate(Vector3(0, 0, 0.1));
	