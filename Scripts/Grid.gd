extends Spatial

export(float) var cellsize = 1.1
export(int) var gridxsize = 11
export(int) var gridysize = 10

var gridarray

var grid_mid_point

func create_2d_array(xsize, ysize, value):
    var a = []

    for x in range(xsize):
        a.append([])
        a[x].resize(ysize)

        for y in range(ysize):
            a[x][y] = value;

    return a

func fill_grid(grid):
	for x in range(gridxsize):
		for y in range(gridysize):
			grid[x][y] = preload("res://Scenes/Cell.tscn").instance()
			grid[x][y].translate(Vector3(x * 2 * cellsize, 0, y * 2 * cellsize))
			add_child(grid[x][y], true);


func _ready():
	
	
	gridarray = create_2d_array(gridxsize, gridysize, null);
	fill_grid(gridarray);
	
	grid_mid_point = Vector3(gridxsize *  cellsize + translation.x, translation.y, gridysize * cellsize + translation.z);
	print_debug(grid_mid_point);
	
	
	
	
	
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
