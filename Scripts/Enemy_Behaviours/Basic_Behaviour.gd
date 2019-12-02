extends Spatial

onready var game = find_parent("Game");
onready var owner_enemy = get_parent();
onready var obstacles = game.obstacles
onready var enemies = game.enemies
onready var characters = game.characters

func behaveiour():
	
	obstacles = game.obstacles;
	enemies = game.enemies;
	characters = game.characters;
	
	
	
	pass;

func _ready():
	pass 

