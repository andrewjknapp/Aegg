shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);

	vec3 black = vec3(0,0,0);
	vec3 texture_blacken_rbg = mix(texture_color.rgb, black, 0.6);
	COLOR = vec4(texture_blacken_rbg, texture_color.a);

	// Called for every pixel the material is visible on.
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}
