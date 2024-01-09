shader_type spatial;
render_mode skip_vertex_transform; //Important, we want to adjust it manually

global uniform float x_axis: hint_range(-2.0, 2.0, 0.1 ); 
global uniform float y_axis: hint_range(-2.0, 2.0, 0.1 ); 
uniform sampler2D image_texture: hint_default_white;
uniform sampler2D imaginne_texture_enission: hint_default_black;

float remap(float value, float i_min, float i_max, float o_min, float o_max) {
	return o_min + ((value - i_min) / (i_max - i_min) * (o_max - o_min));
}

void vertex(){
	//Work in viewspace
	VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	float sq_distance = max((VERTEX.z * VERTEX.z) - 30.0, 0.0); 
	VERTEX.x += remap(x_axis,-1.0,1.0,-0.015,0.015) * sq_distance; 
	VERTEX.y += remap(y_axis,-1.0,1.0,-0.015,0.015) * sq_distance; 
}

void fragment() {
	ALBEDO = texture(image_texture, UV.xy).rgb;
	EMISSION = texture(imaginne_texture_enission, UV.xy).rgb;
}
