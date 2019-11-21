extends Spatial

onready var animplayer = $AnimationPlayer;
onready var mesh = $MeshInstance;

onready var game = find_parent("Game");
onready var characters = game.get_node("Characters").get_children();
onready var cur_player = null;

var selected = false
var highlighted = false


func _on_StaticBody_mouse_entered():
	animplayer.play('cell_highlighted');
	highlighted = true;
	
func _on_StaticBody_mouse_exited():
	animplayer.play('cell_lowlighted');
	highlighted = false;


func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if Input.is_action_just_pressed('click'):
		animplayer.stop();
		animplayer.play('cell_clicked');
		selected = !selected
		game.selected_cell = self;
		
		for player in characters:
			if get_node(player.curcell) == self:
				game.selected_player = player;
				cur_player = player;
		
		if game.selected_player != null:
			
			if game.selected_player.curcell != self.get_path():
				game.selected_player.change_player_cell(self.get_path());
				game.selected_player = null;


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "cell_clicked" && highlighted:
		animplayer.play('cell_highlighted');

func _process(delta):
	pass;
