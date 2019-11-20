extends KinematicBody

export(float) var speed = 8
export(float) var jumpforce = 20

var movement = Vector3(0, 0, 0)
var gravity = -70
var camera_angle = 0
var mouse_sensitivity = 0.3


func _ready():
	Input.set_mouse_mode(2)


func _input(event):
	if event is InputEventMouseMotion:
		
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		
		var change = -event.relative.y * mouse_sensitivity
		if change + camera_angle < 90 and change + camera_angle > -90:
			$Camera.rotate_x(deg2rad(change))
			camera_angle *= change
	
	movement.x = 0
	movement.z = 0
	
	var aim = $Camera.global_transform.basis
	
	if Input.is_action_pressed("forward"):
		
		movement -= aim.z  * speed
	
	if Input.is_action_pressed("backward"):
		
		movement += aim.z * speed
	
	if Input.is_action_pressed("left"):
		
		movement -= aim.x * speed
	
	if Input.is_action_pressed("right"):
		
		movement += aim.x * speed
	
	if is_on_floor() or is_on_ceiling():
		movement.y = 0
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		
		movement.y = jumpforce
	
	if Input.is_action_just_released("jump") and movement.y > 0:
		
		movement.y = 0
	


func _process(delta):
	
	movement.y += gravity * delta
	
	movement = move_and_slide(movement, Vector3(0,1,0))

