shader_type canvas_item;

uniform bool whiten = false;

void fragment(){
	vec4 texture_color = texture(TEXTURE, UV);
	if (whiten) {
		vec3 white = vec3(1, 1, 1);
		vec3 texture_whiten_rbg = mix(texture_color.rgb, white, 0.6);
		COLOR = vec4(texture_whiten_rbg, texture_color.a);
	} else {
		COLOR = texture_color;
	}

}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}
