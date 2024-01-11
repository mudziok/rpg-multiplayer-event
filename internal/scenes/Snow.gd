extends GPUParticles3D

var player_node_path = "/root/Game/Player/Surfer"
var player_node

func _ready():
	player_node = get_node(player_node_path)

func _process(delta):
	if player_node:
		global_transform.origin.x = player_node.global_transform.origin.x;
		global_transform.origin.z = player_node.global_transform.origin.z;
