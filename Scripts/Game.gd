extends Spatial

onready var camera = $Camera_Anchor/Camera;
onready var ingame = $Ingame
onready var grid = $Ingame/Grid
onready var characters = $Characters.get_children();
onready var selected_player = null;

var selected_cell

var selected_char


func _ready():
	pass;
	

func _process(delta):
	pass;
	
	

