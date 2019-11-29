extends Spatial

export(bool) var highlighted
export(Vector3) var entity_offset = Vector3(0, 1.5, 0);
export(Vector2) var starting_cell = Vector2(1, 1);
export(int) var max_health = 3;


var cur_cell
var cur_action

onready var game = find_parent("Game");
onready var grid = game.find_node("Grid");
onready var actions = $Actions.get_children();

onready var cur_health = max_health;

onready var animplayer = $AnimationPlayer
onready var mesh = $MeshInstance


func die():
	self.queue_free();

func _ready():
	cur_action = actions[0];
	game.selected_player = self;
	game.find_node("Selection_Arrow").translation = self.translation + Vector3(0, 5, 0);
	cur_action.action(grid.gridarray[starting_cell.x][starting_cell.y]);
	game.selected_player = null;
	cur_action = null;
	pass;

func _process(delta):
	
	if cur_cell != null:
		if cur_cell.highlighted == true and highlighted == false:
			highlighted = true;
		
		if cur_cell.highlighted == false and highlighted == true:
			highlighted = false;
		
		mesh.translation = cur_cell.mesh.translation + entity_offset;
	
	if cur_health <= 0:
		die();
	
	
	