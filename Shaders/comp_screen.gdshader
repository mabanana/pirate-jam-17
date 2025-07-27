shader_type spatial;
uniform sampler2D tex;

void vertex() {
	float height = ((0.5 - UV.x)*(0.5 - UV.x) + (0.5 - UV.y)*(0.5 - UV.y)) * 0.2;
	VERTEX.z -= height - 0.2;
}

void fragment() {
	float fresnel = sqrt(1.0 - dot(NORMAL, VIEW));
	ALBEDO = texture(tex,UV).xyz;
	RIM = 0.2;
	METALLIC = 0.0;
	ROUGHNESS = 0.01 * (1.0 - fresnel);
	ALPHA = texture(tex,UV).a;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
