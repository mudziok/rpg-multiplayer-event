extends StaticBody3D
class_name ground_tile

var obstacle_list: Array

func load_obstacles():
	obstacle_list.append(preload("res://internal/map/obstacles/tree_obstacle.tscn"))
	obstacle_list.append(preload("res://internal/map/obstacles/land_mine.tscn"))
	#może jest jakiś lepszy sposób na dodanie wszystkich scen z konkretnego folderu?

func populate_tile(object_count:int):
	load_obstacles()
	var  size :Vector3 = get_collider_size()
	var x_bound = size.x;
	var z_bound = size.z;
	
	for i in range(growth_function(object_count)):
		var obstacle_position = Vector3(randi()%100*x_bound/100,1,randi()%100*z_bound/100)
		var index:int = possibility_function()
		var obstacle_instance = obstacle_list[index].instantiate()
		obstacle_instance.position = obstacle_position - Vector3(x_bound/2,0,z_bound/2)
		add_child(obstacle_instance)
	
func possibility_function():
	#chodzi o to aby mniejsze liczby miały większą szansę trafienia
	var rand = (randi()%1000)
	var randindex: float=rand
	randindex = pow(randindex/1000.0, 2)
	var index:int = roundi(randindex*(obstacle_list.size()-1))
	return index
	
func growth_function(player_position_z):
	return roundi(pow(player_position_z,0.3));

func get_collider_size():
	return $collider.shape.get_debug_mesh().get_aabb().size
