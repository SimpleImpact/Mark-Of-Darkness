shader_type canvas_item;

uniform float flicker_speed : hint_range(0.0, 20.0) = 5.0;
uniform float intensity : hint_range(0.0, 1.0) = 0.5; // how much the flicker changes brightness
uniform float threshold : hint_range(0.0, 1.0) = 0.9; // how "white" a pixel must be

float hash(vec2 p) {
    // Simple random generator based on UV
    return fract(sin(dot(p ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment() {
    vec4 col = texture(TEXTURE, UV);

    float brightness = dot(col.rgb, vec3(0.3333)); // grayscale approximation

    if (brightness > threshold) {
        // random flicker using time and UV
        float flicker = hash(UV + TIME * flicker_speed);

        // adjust brightness
        col.rgb *= mix(1.0 - intensity, 1.0 + intensity, flicker);
    }

    COLOR = col;
}
