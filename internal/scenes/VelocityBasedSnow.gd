extends GPUParticles3D

var player_node_path = "/root/Game/Player/Camera"
var player_node

func _ready():
	player_node = get_node(player_node_path)

func _process(delta):
	if player_node:
		global_transform.origin = player_node.global_transform.origin;
