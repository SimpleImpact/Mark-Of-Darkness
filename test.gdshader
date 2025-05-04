shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 pixelColor = texture(TEXTURE, UV * vec2(1, 1));
	float brightness = (pixelColor.r + pixelColor.g + pixelColor.b) / 756.0;
	vec4 color = vec4(brightness * 255.0, brightness * 140.0, brightness, pixelColor.a);
	COLOR = color;
}