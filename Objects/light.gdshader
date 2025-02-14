shader_type spatial;

void light() {
    DIFFUSE_LIGHT += LIGHT_COLOR * vec3(1, 0, 0); // Everything except red turns to 0
}