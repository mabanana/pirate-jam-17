shader_type spatial;
render_mode cull_front, unshaded;

uniform vec4 outline_color : source_color = vec4(1,1,1,1);
uniform float outline_width = 5.0;

vec4 vertex_outline(mat4 pm, mat4 mm, vec3 vr, vec3 nor, vec2 vp) {
	vec4 clip_position = pm * (mm * vec4(vr, 1.0));
	vec3 clip_normal = mat3(pm) * (mat3(mm) * nor);
	
	vec2 offset = normalize(clip_normal.xy) / vp * clip_position.w * outline_width * 2.0;
	
	clip_position.xy += offset;
	
	return clip_position;
}

void vertex() {
	// Outline shader
	POSITION = vertex_outline(PROJECTION_MATRIX, MODELVIEW_MATRIX, VERTEX, NORMAL, VIEWPORT_SIZE);
}

void fragment() {
	// Outline shader
	ALBEDO = outline_color.rgb;
	if (outline_color.a < 1.0) {
		ALPHA = outline_color.a;
	}
}