extends Spatial

export(NodePath) var curcell
export(bool) var highlighted
export(Vector3) var char_offset = Vector3(0, 1.5, 0);
export(Vector2) var starting_cell = Vector2(1, 1);


onready var game = find_parent("Game");
onready var grid = game.find_node("Grid");

onready var animplayer = $AnimationPlayer
onready var mesh = $MeshInstance


func change_player_cell(cell):
	curcell = cell;
	translation = game.get_node(cell).translation ;

func _ready():
	change_player_cell(grid.gridarray[starting_cell.x][starting_cell.y].get_path());


func _process(delta):
	
	if get_node(curcell).highlighted == true and highlighted == false:
		highlighted = true;
		
	
	if get_node(curcell).highlighted == false and highlighted == true:
		highlighted = false;
	
	mesh.translation = game.get_node(curcell).mesh.translation + char_offset;
	
	
	